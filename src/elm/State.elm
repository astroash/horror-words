module State exposing (..)

import Types exposing (..)


-- Model


model : Model
model =
    { route = HomeRoute
    , userInput = ""
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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change newInput ->
            ( { model | userInput = newInput }, Cmd.none )

        UrlChange location ->
            { model | route = (getPage location.hash) } ! [ Cmd.none ]

        SubmitFilmSearch ->
            ( model, Cmd.none )

        SubmitSuggestion ->
            ( model, Cmd.none )
