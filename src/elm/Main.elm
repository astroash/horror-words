module Main exposing (main)

import Navigation


-- My Elm Files

import State exposing (model, update)
import View exposing (view)
import Types exposing (Model, Msg(..))
import Ports exposing (receiveSuggestions)


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = \_ -> ( model, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> receiveSuggestions GotSuggestions
        }
