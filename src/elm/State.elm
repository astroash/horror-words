module State exposing (..)

import Types exposing (..)
import Ports exposing (..)
import Json.Decode as Decode
import Json.Decode.Pipeline as Pipeline
import Json.Encode as Json


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
    Decode.at [ "suggestions" ] (Decode.list suggestionsDecoder)


suggestionsDecoder : Decode.Decoder Suggestion
suggestionsDecoder =
    Pipeline.decode Suggestion
        |> Pipeline.required "film" Decode.string
        |> Debug.log "pipe1"
        |> Pipeline.required "name" Decode.string
        |> Debug.log "pipe2"
        |> Pipeline.required "url" Decode.string
        |> Debug.log "pipe3"


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

                -- newSuggestions =
                --     case json of
                --         Ok list ->
                --             list
                --         Err list ->
                --             []
            in
                ( { model | suggestions = Debug.log "decoder" newSuggestions }, Cmd.none )
