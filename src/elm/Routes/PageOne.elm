module Routes.PageOne exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


pageOne : Model -> Html Msg
pageOne model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1 ma0" ] [ text "Find your horror" ]

        -- , p [ class "tc f3 ma2" ] [ text "coming soon..." ]
        -- , Html.form [ class "tc" ]
        --     [ input [ class "f3 w30 pa1 center tc", onInput Change, value model.userInput, placeholder "I have no imagination" ] []
        --     , button [ class "f3 w30 pa1 center tc" ] [ text "search" ]
        --     ]
        , ul
            [ class "dib ma0 w-100 pa2" ]
          <|
            content
                model.suggestions
        ]


contentItem : Suggestion -> Html Msg
contentItem suggestion =
    li [ class "list li-gradient ma4 pa2 br2" ]
        [ a [ class "flex justify-between items-end", href suggestion.url, target "_blank" ]
            [ h2 [ class "dib ma0 mt4 ml2" ] [ text suggestion.film ]
            , p [ class "dib ma0 mr2 self-start" ] [ text suggestion.name ]
            ]
        ]


content : Maybe (List Suggestion) -> List (Html Msg)
content list =
    case list of
        Just list ->
            List.map contentItem list

        Nothing ->
            [ li []
                [ h2 [] [ text "Error retreving DATA" ]
                ]
            ]
