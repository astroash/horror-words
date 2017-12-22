module Types exposing (..)

import Navigation
import Json.Encode as Json
import Http


-- Model


type Route
    = HomeRoute
    | PageOneRoute
    | PageTwoRoute


type alias Model =
    { route : Route
    , homePageView : HomePageView
    , userInput : String
    , filmSearchOptions : List FilmOption
    , filmSearchDetail : Maybe FilmDetail
    , suggestions : Maybe (List Suggestion)
    }


type HomePageView
    = FirstView
    | FilmOptionsView
    | FilmDetailsView
    | FilmSuggestionsView


type alias Suggestion =
    { name : String
    , film : String
    , url : String

    -- , details : Maybe FilmDetails
    }


type alias FilmDetail =
    { title : String
    , year : String
    , runtime : Int
    , plot : String
    , poster : String
    , director : String
    }


type alias FilmOption =
    { title : String
    , filmId : Int
    , posterPath : String
    }


type alias ApiCrewMember =
    { job : String
    , name : String
    }



-- Update


type Msg
    = Change String
    | UrlChange Navigation.Location
    | SubmitInitialFilmSearch String
    | SubmitSelectedFilm String
    | SubmitSuggestionToDb String
    | GotSuggestions Json.Value
    | ReceiveFilmOptions (Result Http.Error (List FilmOption))
    | ReceiveFilmDetails (Result Http.Error ( String -> FilmDetail, String ))
