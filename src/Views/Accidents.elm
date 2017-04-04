module Views.Accidents exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, colspan, scope, attribute)
import Msgs exposing (Msg)


view :  Html msg
view =
    div [] [ text "Accidents" ]