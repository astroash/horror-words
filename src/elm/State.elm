module State exposing (..)

import Types exposing (..)
import Ports exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline


-- Model


model : Model
model =
    { route = HomeRoute
    , userInput = ""
    , suggestions = Nothing
    }



-- Update


getPage : String -> Route
getPage hash =
    case hash of
        "#home" ->
            HomeRoute

        "#pageone" ->
            PageOneRoute

        "#pagetwo" ->
            PageTwoRoute

        _ ->
            HomeRoute


decodeSuggestions : Decode.Decoder (List Suggestion)
decodeSuggestions =
    Decode.list suggestionsDecoder


suggestionsDecoder : Decode.Decoder Suggestion
suggestionsDecoder =
    Pipeline.decode Suggestion
        |> Pipeline.required "film" Decode.string
        |> Pipeline.required "name" Decode.string
        |> Pipeline.required "url" Decode.string


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "update" msg of
        Change newInput ->
            ( { model | userInput = newInput }, Cmd.none )

        UrlChange location ->
            { model | route = (getPage location.hash) } ! [ Cmd.none ]

        SubmitFilmSearch ->
            ( model, Cmd.none )

        SubmitSuggestion string ->
            ( model, changeSuggestions string )

        GotSuggestions json ->
            let
                newSuggestions =
                    Decode.decodeValue decodeSuggestions (Debug.log "json" json)
                        |> Result.toMaybe
            in
                ( { model | suggestions = Debug.log "decoder" newSuggestions }, Cmd.none )
