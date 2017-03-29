module Views.Leaders.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Msgs exposing (Msg)
import Models exposing (Leader)


view : List Leader -> Html Msg
view leaders =
    div []
        [ nav
        , list leaders
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Leaders" ] ]


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
