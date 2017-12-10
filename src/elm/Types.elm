module Types exposing (..)

import Navigation
import Json.Encode as Json


-- Model


type Route
    = HomeRoute
    | PageOneRoute
    | PageTwoRoute


type alias Model =
    { route : Route
    , userInput : String
    , suggestions : Maybe (List Suggestion)
    }


type alias Suggestion =
    { name : String
    , film : String
    , url : String
    }



-- Update


type Msg
    = Change String
    | UrlChange Navigation.Location
    | SubmitFilmSearch
    | SubmitSuggestion String
    | GotSuggestions Json.Value
