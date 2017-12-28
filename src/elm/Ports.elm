port module Ports exposing (sendSuggestions, receiveSuggestions)

import Types exposing (FilmDetail)
import Json.Encode as Json


port sendSuggestions : FilmDetail -> Cmd msg


port receiveSuggestions : (Json.Value -> msg) -> Sub msg
