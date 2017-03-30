module Views.Dashboard exposing (..)

import Html exposing (Html, div, text, nav, img, a)
import Html.Attributes exposing (class, href, src, height, width)
import Msgs exposing (Msg)
import Models exposing (Model)
import Views.Leaders.List


view : Model -> Html Msg
view model =
    nav [ class "navbar navbar-inverse bg-inverse" ]
            [ a [ class "navbar-brand", href "#" ] 
                [ img [ src "http://seeklogo.com/images/E/elm-logo-9DEF2A830B-seeklogo.com.png", 
                        height 60,
                        width 60 ] 
                    [] 
                ] 
            ]


page : Model -> Html Msg
page model =
    Views.Leaders.List.view model.leaders
