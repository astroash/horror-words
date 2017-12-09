port module Ports exposing (..)

import Json.Encode as Json


port changeSuggestions : String -> Cmd msg


port receiveSuggestions : (Json.Value -> msg) -> Sub msg
