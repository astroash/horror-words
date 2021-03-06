module Components.Navbar exposing (navbar)

import Html exposing (Html, a, li, text, ul)
import Html.Attributes exposing (class, href)
import Types exposing (Msg)


navbar : Html Msg
navbar =
    ul [ class "dib ma0 w-100 pa2 drip" ]
        navbarContent


navbarLink : ( String, String ) -> Html Msg
navbarLink ( linkStr, name ) =
    li [ class "list dib ma3 pb6--m" ] [ a [ class "link dim white b", href ("/#" ++ linkStr) ] [ text name ] ]


navbarContent : List (Html Msg)
navbarContent =
    List.map navbarLink [ ( "home", "I wanna watch..." ), ( "suggestions", "Suggestions" ) ]
