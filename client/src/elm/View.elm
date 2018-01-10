module View exposing (view)

-- My Elm Files

import Components.Navbar exposing (navbar)
import Html exposing (Html, div)
import Routes.HomePage exposing (homePage)
import Routes.SuggestionsPage exposing (suggestionPage)
import Types exposing (Model, Msg, Route(..))


view : Model -> Html Msg
view model =
    let
        page =
            case model.route of
                HomeRoute ->
                    homePage model

                SuggestionsRoute ->
                    suggestionPage model
    in
    div []
        [ navbar
        , page
        ]
