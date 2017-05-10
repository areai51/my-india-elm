module Views.Crimes exposing (..)

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
    h1 [] [ text "State wise Crime Against Women" ]


barChart : Html msg
barChart =
    section [ class "bar-chart__wrapper", style [ ( "background", "#fff" ), ( "padding", "20px" ) ] ]
        [ canvas [ class "bar-chart", attribute "height" "600", id "bar-chart", attribute "width" "400" ]
            []
        ]
