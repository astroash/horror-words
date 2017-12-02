module Routes.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


home : Model -> Html Msg
home model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1 ma0" ] [ text "⚠️" ]
        , p [ class "f3 w60 tc ma0" ] [ text "Share your fears" ]
        , Html.form [ class "tc", onSubmit SubmitSuggestion ]
            [ input [ class "f4 w30 ma1 pa1 center tc", onInput Change, value model.userInput, placeholder "the scariest of scares" ] []
            , button [ class "f4 w30 pa1 center tc" ] [ text "add" ]
            ]
        ]
