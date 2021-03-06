module Types exposing (ApiCrewMember, FilmDetail, FilmOption, HomePageView(..), Model, Msg(..), Route(..))

import Http
import Json.Encode as Json
import Navigation


-- Model


type Route
    = HomeRoute
    | SuggestionsRoute


type alias Model =
    { route : Route
    , homePageView : HomePageView
    , userInput : String
    , filmSearchOptions : List FilmOption
    , filmSearchDetail : Maybe FilmDetail
    , suggestions : Maybe (List FilmDetail)
    , inFocusSuggestion : Int
    }


type HomePageView
    = FirstView
    | FilmOptionsView
    | FilmDetailsView
    | FilmSuggestionsView


type alias FilmDetail =
    { filmId : Int
    , title : String
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
    | SubmitSuggestionToDb FilmDetail
    | UpdateInFocusSuggestion Int
    | GotSuggestions Json.Value
    | ReceiveFilmOptions (Result Http.Error (List FilmOption))
    | ReceiveFilmDetails (Result Http.Error ( String -> FilmDetail, String ))
