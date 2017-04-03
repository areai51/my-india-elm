module Views.Leaders.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, colspan, scope, attribute)
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
    table [ class "table", style [("width", "50%"), ("height", "100%")] ]
        [ thead [class "thead-inverse"] [ tr []
                    [ th [] [ text "#" ] ,
                      th [ colspan 2 ] [ text "Lok Sabha 15 - Attendence" ]
                    ]
                ], 
          tbody [] (List.indexedMap leaderRow leaders)
        ]


leaderRow : Int -> Leader -> Html Msg
leaderRow index leader =
    tr []
        [
          th [ scope "row" ] [ text (toString (index + 1)) ]
        , td [] [ 
              p [ class "font-weight-bold" ] [ text leader.name ],
              p [ class "font-italic" ] [ text leader.state ]
            ]
        , td [] [
              div [ class "progress", style [("width", "200px")] ] [ 
                  div [ 
                      class "progress-bar",
                      style [ ("width", (toString (round (leader.attendance))) ++ "%") ],
                      attribute "role" "progressbar",
                      attribute "aria-valuenow" (toString (round (leader.attendance))),
                      attribute "aria-valuemin" "0",
                      attribute "aria-valuemax" "100"
                      ] [ text ((toString (round (leader.attendance))) ++ "%") ]
               ]
            ]
        ]
