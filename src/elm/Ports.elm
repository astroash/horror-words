port module Ports exposing (..)

import Types exposing (..)
import Json.Encode as Json


port sendSuggestions : FilmDetail -> Cmd msg


port receiveSuggestions : (Json.Value -> msg) -> Sub msg
