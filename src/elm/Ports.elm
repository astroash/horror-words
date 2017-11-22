port module Ports exposing (..)

-- import Html exposing (..)
--
--
-- type alias Model =
--     { suggestions : Maybe List }
--
--
-- type Msg
--     = NoMsgYet
--
--
-- initialModel : Model
-- initialModel =
--     { suggestions = Nothing }
--
--
-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--     ( model, Cmd.none )
--
--
-- view : Model -> Html msg
-- view model =
--     Html.text <| toString model


port changeSuggestions : String -> Cmd msg



-- main : Program Never Model Msg
-- main =
--     Html.program
--         { init = ( initialModel, Cmd.none )
--         , update = update
--         , subscriptions = \_ -> Sub.none
--         , view = view
--         }
