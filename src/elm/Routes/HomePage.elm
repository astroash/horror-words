module Routes.HomePage exposing (homePage)

import Html exposing (Html, div, h1, h2, p, button, input, ul, li, img, text)
import Html.Attributes exposing (class, src, placeholder, value)
import Html.Events exposing (onInput, onClick)
import Types exposing (Model, Msg(..), FilmOption, HomePageView(..))
import Components.FilmDescription exposing (filmDescHtml)


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
                    case model.filmSearchDetail of
                        Just filmDetail ->
                            filmDescHtml filmDetail True

                        Nothing ->
                            div [ class "db ma0 white" ] [ text "There has been an error" ]

                FilmSuggestionsView ->
                    div [] []
    in
        div [ class "w-80-ns w-60-m center" ]
            [ h1 [ class "tc f1 ma0 emoji" ] [ text "⚠️" ]
            , p [ class "f2 w60 tc ma0 mb1" ] [ text "Find your fears" ]
            , Html.form [ class "tc", onInput SubmitInitialFilmSearch ]
                [ input [ class "f4 w30 ma1 pa1 center tc", onInput Change, value model.userInput, placeholder "the scariest of scares" ] []
                ]
            , changeView
            ]


contentItem : FilmOption -> Html Msg
contentItem filmOption =
    li [ class <| "dib list " ++ itemBg ]
        [ button [ class "w-100 bg-transparent", onClick <| SubmitSelectedFilm <| toString filmOption.filmId ]
            [ h2 [ class "db ma0 white" ] [ text filmOption.title ]
            , img [ class "db ma0", src <| "http://image.tmdb.org/t/p/w185//" ++ filmOption.posterPath ] [ text filmOption.title ]
            ]
        ]


itemBg : String
itemBg =
    "li-gradient ma1 pa2 br2"
