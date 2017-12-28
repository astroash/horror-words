module Components.FilmDescription exposing (filmDescHtml)

import Html exposing (Html, div, button, img, p, h2, text)
import Html.Attributes exposing (class, src, classList)
import Html.Events exposing (onClick)
import Types exposing (FilmDetail, Msg(..))


filmDescHtml : FilmDetail -> Bool -> Html Msg
filmDescHtml filmDetail addButton =
    let
        buttonHtml =
            case addButton of
                True ->
                    button [ class "w-20 bg-green mr2 br2", onClick <| SubmitSuggestionToDb filmDetail ]
                        [ p [ class "f4" ] [ text "Add Film" ]
                        ]

                False ->
                    div [] []
    in
        div [ class <| "h-100 flex items-center mt2 li-gradient ma1 pa2 br2" ]
            [ div
                [ class "w-20 ml2" ]
                [ img [ src <| "http://image.tmdb.org/t/p/w185//" ++ filmDetail.poster ] []
                ]
            , div
                [ class "dib w-60 ph3"
                , classList [ ( "w-60", addButton ), ( "w-80", not addButton ) ]
                ]
                [ h2 [ class "tc mv2" ] [ text filmDetail.title ]
                , p [ class "sans-serif f6" ] [ text filmDetail.plot ]
                , p [ class "mb1" ] [ text <| "Director: " ++ filmDetail.director ]
                , p [ class "mv0" ] [ text <| "Runtime: " ++ toString filmDetail.runtime ]
                ]
            , buttonHtml
            ]
