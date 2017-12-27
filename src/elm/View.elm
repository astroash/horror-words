module View exposing (..)

import Html exposing (..)


-- My Elm Files

import Types exposing (..)
import Routes.HomePage exposing (..)
import Routes.PageOne exposing (..)
import Routes.PageTwo exposing (..)
import Components.Navbar exposing (..)


view : Model -> Html Msg
view model =
    let
        page =
            case model.route of
                HomeRoute ->
                    homePage model

                PageOneRoute ->
                    pageOne model

                PageTwoRoute ->
                    pageTwo model
    in
        div []
            [ navbar model
            , page
            ]
