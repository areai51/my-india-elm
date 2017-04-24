module Views.Leaders exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, colspan, scope, attribute)
import Msgs exposing (Msg)
import Models exposing (Leader)
import RemoteData exposing (WebData)


view : WebData (List Leader) -> WebData (List Leader) -> Html Msg
view lsResponse rsResponse =
    div [ style [ ( "height", "100%" ), ( "overflow", "hidden" ), ( "overflow-y", "auto" ) ] ]
        [ nav
        , div [ class "our-leaders__data-list-wrapper" ]
            [ maybeLsList lsResponse
            , maybeRsList rsResponse
            ]
        ]


nav : Html msg
nav =
    h1 [] [ text "Our Leaders" ]


maybeLsList : WebData (List Leader) -> Html Msg
maybeLsList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success leaders ->
            list (List.reverse (List.sortBy .attendance leaders)) "Lok Sabha 15 - Attendence"

        RemoteData.Failure error ->
            text (toString error)


maybeRsList : WebData (List Leader) -> Html Msg
maybeRsList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success leaders ->
            list (List.reverse (List.sortBy .attendance leaders)) "Rajya Sabha 15 - Attendence"

        RemoteData.Failure error ->
            text (toString error)


list : List Leader -> String -> Html Msg
list leaders title =
    div [ class "our-leaders__data-list" ]
        [ div [ class "data-list__wrapper" ]
            [ div [ class "data-list__container" ]
                [ h2 [ class "data-list__title" ]
                    [ span []
                        [ text title ]
                    ]
                , div [ class "data-list__list" ] (List.indexedMap leaderRow leaders)
                ]
            ]
        ]


leaderRow : Int -> Leader -> Html Msg
leaderRow index leader =
    ul [ class "data-row" ]
        [ li [ class "data-column" ]
            [ span [ class "data-list__serial-no" ]
                [ text (toString (index + 1)) ]
            ]
        , li [ class "data-column" ]
            [ span [ class "data-list__member-name" ]
                [ text leader.name ]
            , span [ class "data-list__member-state" ]
                [ em []
                    [ text leader.state ]
                ]
            ]
        , li [ class "data-column" ]
            [ div [ class "progress-bar horizontal" ]
                [ div [ class "progress-track" ]
                    [ span [ class "progress-info" ]
                        [ text ((toString (round (leader.attendance))) ++ "%") ]
                    , div [ class "progress-fill", style [ ( "width", (toString (round (leader.attendance))) ++ "%" ) ] ]
                        []
                    ]
                ]
            ]
        ]
