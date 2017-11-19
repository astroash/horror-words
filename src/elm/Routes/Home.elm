module Routes.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


home : Model -> Html Msg
home model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1" ] [ text "hello" ]
        , p [ class "f3 w60 mh1 tc" ] [ text "Share your horror suggestions" ]
        , Html.form [ class "tc", onSubmit SubmitSuggestion ]
            [ input [ class "f3 w30 pa1 center tc", onInput Change, value model.userInput, placeholder "the scariest of scares" ] []
            , button [ class "f3 w30 pa1 center tc" ] [ text "add" ]
            ]
        ]
