module State exposing (model, update)

import Types exposing (Model, Msg(..), Route(..), HomePageView(..), ApiCrewMember, FilmDetail, FilmOption)
import Ports exposing (sendSuggestions)
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline
import Http
import Task
import Config exposing (apiKey)
import Navigation


-- Model


model : Model
model =
    { route = HomeRoute
    , homePageView = FirstView
    , userInput = ""
    , filmSearchOptions = []
    , filmSearchDetail = Nothing
    , suggestions = Nothing
    , inFocusSuggestion = 0
    }



-- Update


getPage : String -> Route
getPage hash =
    case hash of
        "#home" ->
            HomeRoute

        "#suggestions" ->
            SuggestionsRoute

        _ ->
            HomeRoute



-- fb decoding


decodeSuggestions : Decode.Decoder (List FilmDetail)
decodeSuggestions =
    Decode.list suggestionsDecoder


suggestionsDecoder : Decode.Decoder FilmDetail
suggestionsDecoder =
    Pipeline.decode FilmDetail
        |> Pipeline.required "filmId" Decode.int
        |> Pipeline.required "title" Decode.string
        |> Pipeline.required "year" Decode.string
        |> Pipeline.required "runtime" Decode.int
        |> Pipeline.required "plot" Decode.string
        |> Pipeline.required "poster" Decode.string
        |> Pipeline.required "director" Decode.string



-- movie options decoder


filmOptionsDecoder : Decode.Decoder FilmOption
filmOptionsDecoder =
    Pipeline.decode FilmOption
        |> Pipeline.required "title" Decode.string
        |> Pipeline.required "id" Decode.int
        |> Pipeline.required "poster_path" Decode.string


filmOptionsListDecoder : Decode.Decoder (List FilmOption)
filmOptionsListDecoder =
    Pipeline.decode (\a b c -> [ a, b, c ])
        |> Pipeline.custom (Decode.index 0 filmOptionsDecoder)
        |> Pipeline.custom (Decode.index 1 filmOptionsDecoder)
        |> Pipeline.custom (Decode.index 2 filmOptionsDecoder)


filmOptionsResultsDecoder : Decode.Decoder (List FilmOption)
filmOptionsResultsDecoder =
    Decode.field "results" (filmOptionsListDecoder)



-- movie options api call


filmOptionsApiCall : String -> Cmd Msg
filmOptionsApiCall film =
    let
        url =
            "https://api.themoviedb.org/3/search/movie?api_key=" ++ apiKey ++ "&query=" ++ film ++ "&page=1&include_adult=false"

        request =
            Http.get url filmOptionsResultsDecoder
    in
        Http.send ReceiveFilmOptions request



-- movie details decoder


filmDetailsDecoder : Decode.Decoder (String -> FilmDetail)
filmDetailsDecoder =
    Pipeline.decode FilmDetail
        |> Pipeline.required "id" Decode.int
        |> Pipeline.required "title" Decode.string
        |> Pipeline.required "release_date" Decode.string
        |> Pipeline.required "runtime" Decode.int
        |> Pipeline.required "overview" Decode.string
        |> Pipeline.required "poster_path" Decode.string


itemDecoder : Decode.Decoder ApiCrewMember
itemDecoder =
    Pipeline.decode ApiCrewMember
        |> Pipeline.required "job" Decode.string
        |> Pipeline.required "name" Decode.string


filmDirectorFoldDecoder : Decode.Decoder String
filmDirectorFoldDecoder =
    Decode.list itemDecoder
        |> Decode.andThen
            (List.foldl
                (\item acc ->
                    if item.job == "Director" then
                        Just item.name
                    else
                        acc
                )
                Nothing
                >> Maybe.map Decode.succeed
                >> Maybe.withDefault (Decode.fail "Item not found!")
            )


filmDirectorDecoder : Decode.Decoder String
filmDirectorDecoder =
    Decode.field "crew" (filmDirectorFoldDecoder)


filmSelectedApiCall : String -> Cmd Msg
filmSelectedApiCall filmId =
    let
        urlDeets =
            "https://api.themoviedb.org/3/movie/" ++ filmId ++ "?api_key=" ++ apiKey

        urlDirector =
            "https://api.themoviedb.org/3/movie/" ++ filmId ++ "/credits?api_key=" ++ apiKey

        request1 =
            Http.get urlDeets filmDetailsDecoder

        request2 =
            Http.get urlDirector filmDirectorDecoder

        test =
            "test"
    in
        Task.map2 (,) (Http.toTask request1) (Http.toTask request2)
            |> Task.attempt ReceiveFilmDetails



--  `(,)` is equivalent to `(\r1 r2 -> (r1, r2))`. It takes two values and puts them in a tuple


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change newInput ->
            ( { model | userInput = newInput }, Cmd.none )

        UrlChange location ->
            { model | route = (getPage location.hash) } ! [ Cmd.none ]

        SubmitInitialFilmSearch film ->
            ( model, filmOptionsApiCall film )

        SubmitSelectedFilm filmId ->
            ( model, filmSelectedApiCall filmId )

        SubmitSuggestionToDb filmDetail ->
            ( { model | inFocusSuggestion = filmDetail.filmId }, Cmd.batch [ sendSuggestions filmDetail, Navigation.newUrl ("#pageone") ] )

        GotSuggestions json ->
            let
                newSuggestions =
                    Decode.decodeValue decodeSuggestions json
                        |> Result.toMaybe
            in
                ( { model | suggestions = newSuggestions }, Cmd.none )

        ReceiveFilmOptions (Ok data) ->
            ( { model | filmSearchOptions = data, homePageView = FilmOptionsView }, Cmd.none )

        ReceiveFilmOptions (Err err) ->
            let
                log =
                    Debug.log "ERR" err
            in
                ( model, Cmd.none )

        ReceiveFilmDetails (Ok ( result, result2 )) ->
            let
                mergeDetail =
                    result result2

                sanitisedYear =
                    case (sanitiseDate mergeDetail.year) of
                        Just year ->
                            year

                        Nothing ->
                            "Unknown"

                filmDetail =
                    { mergeDetail | year = sanitisedYear }
            in
                ( { model | filmSearchDetail = Just filmDetail, homePageView = FilmDetailsView }, Cmd.none )

        ReceiveFilmDetails (Err err) ->
            let
                log =
                    Debug.log "ERR" err
            in
                ( model, Cmd.none )

        UpdateInFocusSuggestion int ->
            ( { model | inFocusSuggestion = int }, Cmd.none )


sanitiseDate : String -> Maybe String
sanitiseDate strDate =
    strDate
        |> String.split "-"
        |> List.head
