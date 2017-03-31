module Views.Leaders.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Leader)
import RemoteData exposing (WebData)


view : WebData (List Leader) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]


nav : Html Msg
nav =
    h1 [ ] [ text "Our Leaders" ]


maybeList : WebData (List Leader) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success leaders ->
            list leaders

        RemoteData.Failure error ->
            text (toString error)


list : List Leader -> Html Msg
list leaders =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Attendance" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "State" ]
                    ]
                ]
            , tbody [] (List.map leaderRow leaders)
            ]
        ]


leaderRow : Leader -> Html Msg
leaderRow leader =
    tr []
        [ td [] [ text (toString leader.attendance) ]
        , td [] [ text leader.name ]
        , td [] [ text leader.state ]
        ]
