port module Ports exposing (receiveSuggestions, sendSuggestions)

import Json.Encode as Json
import Types exposing (FilmDetail)


port sendSuggestions : FilmDetail -> Cmd msg


port receiveSuggestions : (Json.Value -> msg) -> Sub msg
