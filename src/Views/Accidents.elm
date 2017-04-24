module Views.Accidents exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, colspan, scope, attribute, id)
import Msgs exposing (Msg)


view : Html msg
view =
    div [ style [ ( "height", "100%" ), ( "overflow", "hidden" ), ( "overflow-y", "auto" ) ] ]
        [ nav
        , barChart
        ]


nav : Html msg
nav =
    h1 [] [ text "City wise Accidents" ]


barChart : Html msg
barChart =
    div [ class "bar-chart__wrapper" ]
        [ canvas [ class "bar-chart", attribute "height" "400", id "bar-chart", attribute "width" "400" ]
            []
        ]
