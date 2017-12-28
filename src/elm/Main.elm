module Main exposing (main)

-- My Elm Files

import Navigation
import Ports exposing (receiveSuggestions)
import State exposing (model, update)
import Types exposing (Model, Msg(..))
import View exposing (view)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = \_ -> ( model, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> receiveSuggestions GotSuggestions
        }
