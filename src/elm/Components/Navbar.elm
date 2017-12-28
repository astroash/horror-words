module Components.Navbar exposing (navbar)

import Html exposing (Html, ul, li, text, a)
import Html.Attributes exposing (class, href)
import Types exposing (Model, Msg)


navbar : Model -> Html Msg
navbar model =
    ul [ class "dib ma0 w-100 pa2 drip" ]
        navbarContent


navbarLink : ( String, String ) -> Html Msg
navbarLink ( linkStr, name ) =
    li [ class "list dib ma3 pb6--m" ] [ a [ class "link dim white b", href ("/#" ++ linkStr) ] [ text name ] ]


navbarContent : List (Html Msg)
navbarContent =
    List.map navbarLink [ ( "home", "I wanna watch..." ), ( "suggestions", "Suggestions" ) ]
