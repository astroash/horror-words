module Routes.HomePage exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


homePage : Model -> Html Msg
homePage model =
    let
        changeView =
            case model.homePageView of
                FirstView ->
                    div [] []

                FilmOptionsView ->
                    ul
                        [ class "dib ma0 w-100 pa2 flex justify-between" ]
                    <|
                        List.map contentItem model.filmSearchOptions

                FilmDetailsView ->
                    div [] []

                FilmSuggestionsView ->
                    div [] []
    in
        div [ class "w-80-ns w-60-m center" ]
            [ h1 [ class "tc f1 ma0" ] [ text "⚠️" ]
            , p [ class "f3 w60 tc ma0" ] [ text "Share your fears" ]
            , Html.form [ class "tc", onSubmit <| SubmitInitialFilmSearch model.userInput ]
                [ input [ class "f4 w30 ma1 pa1 center tc", onInput Change, value model.userInput, placeholder "the scariest of scares" ] []
                , button [ class "f4 w30 pa1 center tc" ] [ text "add" ]
                ]
            , changeView
            ]


contentItem : FilmOption -> Html Msg
contentItem filmOption =
    li [ class "dib list li-gradient ma1 pa2 br2 " ]
        [ button [ class "w-100 bg-transparent", onClick <| SubmitSelectedFilm <| toString filmOption.filmId ]
            [ h2 [ class "db ma0 ml2 white" ] [ text filmOption.title ]
            , img [ class "db ma0 mr2", src <| "http://image.tmdb.org/t/p/w185//" ++ filmOption.posterPath ] [ text filmOption.title ]
            ]
        ]
