module Routes.PageOne exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


pageOne : Model -> Html Msg
pageOne model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1 ma0" ] [ text "Find your horror" ]
        , p [ class "tc f3 ma2" ] [ text "coming soon..." ]
        , Html.form [ class "tc", onSubmit SubmitFilmSearch ]
            [ input [ class "f3 w30 pa1 center tc", onInput Change, value model.userInput, placeholder "I have no imagination" ] []
            , button [ class "f3 w30 pa1 center tc" ] [ text "search" ]
            ]
        ]
