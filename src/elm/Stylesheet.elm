module Stylesheet exposing (..)

import Color
import Element.Attributes
import Style exposing (..)
import Style.Background as Background
import Style.Color as Color
import Style.Font as Font


type MyStyles
    = NoStyle
    | NavBg
    | NavTitle
    | FilmDeetBg
    | FilmDeetImg
    | FilmDeetTextContainer
    | FilmDeetH2
    | FilmDeetPlot
    | FilmDeetFooter


importFonts : List Font
importFonts =
    let
        fontsList =
            [ { url = "https://fonts.googleapis.com/css?family=Indie+Flower", name = "Indie Flower" }, { url = "https://fonts.googleapis.com/css?family=Montserrat+Alternates", name = "Montserrat Alternates" } ]
    in
    List.map Font.importUrl fontsList


stylesheet : StyleSheet MyStyles variation
stylesheet =
    Style.styleSheet
        [ Style.style NavBg
            [ Background.imageWith { src = "assets/drip-green-gradient.png", position = ( 0, 0 ), repeat = Background.repeatX, size = Background.height <| Element.Attributes.px 150 }
            ]
        , Style.style NavTitle
            [ Color.text Color.white
            , Font.size 20 -- all units given as px
            , Font.lineHeight 1.5
            , Font.typeface
                [ Font.font "Indie Flower"
                , Font.font "Comic Sans"
                , Font.font "Papyrus"
                ]
            ]
        , Style.style FilmDeetH2
            [ Color.text Color.white
            , Font.size 20 -- all units given as px
            , Font.typeface
                [ Font.font "Indie Flower"
                , Font.font "Comic Sans"
                , Font.font "Papyrus"
                ]
            ]
        , Style.style FilmDeetPlot
            [ Color.text Color.white
            , Font.size 20 -- all units given as px
            , Font.typeface
                [ Font.font "Indie Flower"
                , Font.font "Comic Sans"
                , Font.font "Papyrus"
                ]
            ]
        , Style.style FilmDeetFooter
            [ Color.text Color.white
            , Font.size 20 -- all units given as px
            , Font.typeface
                [ Font.font "Indie Flower"
                , Font.font "Comic Sans"
                , Font.font "Papyrus"
                ]
            ]
        ]
