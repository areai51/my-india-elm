module Views.Leaders exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, colspan, scope, attribute)
import Msgs exposing (Msg)
import Models exposing (Leader)
import RemoteData exposing (WebData)


view : WebData (List Leader) -> WebData (List Leader) -> Html Msg
view lsResponse rsResponse =
    div [ style [("height", "100%"), ("overflow", "hidden"), ("overflow-y", "auto")]]
        [ nav
        , maybeLsList lsResponse
        , maybeRsList rsResponse
        ]


nav : Html msg
nav =
    h1 [ ] [ text "Our Leaders" ]


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
    table [ class "table", style [("width", "50%"), ("height", "100%"), ("display", "inline-block")] ]
        [ thead [class "thead-inverse"] [ tr []
                    [ th [] [ text "#" ] ,
                      th [ colspan 2 ] [ text title ]
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
