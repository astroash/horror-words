module Components.Navbar exposing (navbar)

import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (Html)
import Stylesheet exposing (..)
import Types exposing (Msg)


navbar : Html Msg
navbar =
    Element.layout stylesheet <|
        row NavBg [ padding 15, paddingBottom 100, spacing 50 ] <|
            List.map navbarLink [ ( "home", "I wanna watch..." ), ( "suggestions", "Suggestions" ) ]


navbarLink : ( String, String ) -> Element MyStyles variation msg
navbarLink ( linkStr, name ) =
    link ("/#" ++ linkStr) <|
        el NavTitle [ paddingBottom 20 ] <|
            text name
