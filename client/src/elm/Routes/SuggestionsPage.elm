module Routes.SuggestionsPage exposing (suggestionPage)

import Components.FilmDescription exposing (filmDescHtml)
import Html exposing (Html, a, div, h1, h2, li, p, text, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onMouseEnter)
import Types exposing (FilmDetail, Model, Msg(..))


suggestionPage : Model -> Html Msg
suggestionPage model =
    div [ class "w-60-ns center" ]
        [ h1 [ class "tc f1 ma0" ] [ text "Friends & Foes Fears" ]
        , ul
            [ class "dib ma0 w-100 pa2" ]
          <|
            content
                model.suggestions
                model.inFocusSuggestion
        ]


filmSummary : FilmDetail -> Html Msg
filmSummary filmDetail =
    li [ class "list li-gradient ma4 pa2 br2", onMouseEnter <| UpdateInFocusSuggestion filmDetail.filmId ]
        [ a [ class "flex justify-between items-end" ]
            [ h2 [ class "dib ma0 mt4 ml2" ] [ text filmDetail.title ]
            , p [ class "dib ma0 mr2 self-start" ] [ text filmDetail.director ]
            ]
        ]


content : Maybe (List FilmDetail) -> Int -> List (Html Msg)
content maybeList inFocusFilm =
    case maybeList of
        Just list ->
            -- List.map contentItem <| List.reverse list
            List.foldl
                (\filmDetail acc ->
                    let
                        newHtml =
                            case filmDetail.filmId == inFocusFilm of
                                True ->
                                    filmDescHtml filmDetail False

                                False ->
                                    filmSummary filmDetail
                    in
                    newHtml :: acc
                )
                []
                list

        Nothing ->
            [ li []
                [ h2 [] [ text "Error retreving DATA" ]
                ]
            ]
