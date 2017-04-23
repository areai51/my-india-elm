module Views.Rivers exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, colspan, scope, attribute)
import Msgs exposing (Msg)
import Models exposing (River)
import RemoteData exposing (WebData)


view : WebData (List River) -> Html Msg
view response =
    div [ style [("height", "100%"), ("overflow", "hidden"), ("overflow-y", "auto")]]
        [ nav
        , maybeList response
        ]


nav : Html msg
nav =
    h1 [ ] [ text "Our Rivers" ]


maybeList : WebData (List River) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success rivers ->
            list (List.sortBy .state (List.filter isNotEmptyRecord rivers))

        RemoteData.Failure error ->
            text (toString error)


list : List River -> Html Msg
list rivers =
    table [ class "rivers", style [("width", "100%"), ("height", "100%")] ]
        [ thead [class "thead-inverse"] [ tr []
                    [ th [] [ text "State" ],
                      th [] [ text "Location" ],
                      th [] [ text "Max Temp." ],
                      th [] [ text "Min Temp." ],
                      th [] [ text "PH Value Max" ],
                      th [] [ text "PH Value Min" ]
                    ]
                ], 
          tbody [] (List.indexedMap riverRow rivers)
        ]


riverRow : Int -> River -> Html Msg
riverRow index river =
    tr []
        [
          td [] [ text river.state ]
        , td [] [ text river.location ]
        , td [] [ text river.maxTemp ]
        , td [] [ text river.minTemp ]
        , td [] [ text river.maxPH ]
        , td [] [ text river.minPH ]
        ]


isNotEmptyRecord : River -> Bool
isNotEmptyRecord river =
    if String.isEmpty river.state then
        False
    else
        True
