module Components.FilmDescription exposing (filmDescHtml)

import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Stylesheet exposing (..)
import Types exposing (FilmDetail, Msg(..))


filmDescHtml : FilmDetail -> Bool -> Html Msg
filmDescHtml filmDetail addButton =
    Element.layout stylesheet <|
        row FilmDeetBg
            [ width fill ]
            [ row NoStyle [ width (fillPortion 1), center ] [ image FilmDeetImg [ maxHeight (px 200), center ] { src = "http://image.tmdb.org/t/p/w185//" ++ filmDetail.poster, caption = "" } ]
            , column FilmDeetTextContainer
                [ center, width (fillPortion 2), spacing 10 ]
                [ h2 FilmDeetH2 [] (text filmDetail.title)
                , paragraph FilmDeetPlot [] [ text filmDetail.plot ]
                , el FilmDeetFooter [] (text <| "Director: " ++ filmDetail.director)
                , el FilmDeetFooter [] (text <| "Runtime: " ++ toString filmDetail.runtime)
                , el FilmDeetFooter [] (text <| "Year: " ++ filmDetail.year)
                ]
            ]



-- div [ class <| "h-100 flex items-center mt2 li-gradient ma1 pa2 br2" ]
--         [ div
--             [ class "w-20 ml2" ]
--             [ img [ src <| "http://image.tmdb.org/t/p/w185//" ++ filmDetail.poster ] []
--             ]
--         , div
--             [ class "dib w-60 ph3"
--             , classList [ ( "w-60", addButton ), ( "w-80", not addButton ) ]
--             ]
--             [ h2 [ class "tc mv2" ] [ text filmDetail.title ]
--             , p [ class "sans-serif f6" ] [ text filmDetail.plot ]
--             , p [ class "mb1" ] [ text <| "Director: " ++ filmDetail.director ]
--             , p [ class "mv0 dib" ] [ text <| "Runtime: " ++ toString filmDetail.runtime ]
--             , p [ class "ml5 dib" ] [ text <| "Year: " ++ filmDetail.year ]
--             ]
-- let
--     buttonHtml =
--         case addButton of
--             True ->
--                 button [ class "w-20 bg-green mr2 br2", onClick <| SubmitSuggestionToDb filmDetail ]
--                     [ p [ class "f4" ] [ text "Add Film" ]
--                     ]
--             False ->
--                 div [] []
-- in
-- div [ class <| "h-100 flex items-center mt2 li-gradient ma1 pa2 br2" ]
--     [ div
--         [ class "w-20 ml2" ]
--         [ img [ src <| "http://image.tmdb.org/t/p/w185//" ++ filmDetail.poster ] []
--         ]
--     , div
--         [ class "dib w-60 ph3"
--         , classList [ ( "w-60", addButton ), ( "w-80", not addButton ) ]
--         ]
--         [ h2 [ class "tc mv2" ] [ text filmDetail.title ]
--         , p [ class "sans-serif f6" ] [ text filmDetail.plot ]
--         , p [ class "mb1" ] [ text <| "Director: " ++ filmDetail.director ]
--         , p [ class "mv0 dib" ] [ text <| "Runtime: " ++ toString filmDetail.runtime ]
--         , p [ class "ml5 dib" ] [ text <| "Year: " ++ filmDetail.year ]
--         ]
--     , buttonHtml
--     ]
