module View exposing (view)

import Html exposing (Html, div)


-- My Elm Files

import Types exposing (Model, Msg, Route(..))
import Routes.HomePage exposing (homePage)
import Routes.SuggestionsPage exposing (suggestionPage)
import Components.Navbar exposing (navbar)


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
            [ navbar model
            , page
            ]
