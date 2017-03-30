module Views.Dashboard exposing (..)

import Html exposing (Html, div, text, nav, img, a, button)
import Html.Attributes exposing (class, href, src, height, width, style)
import Msgs exposing (Msg)
import Models exposing (Model)
import Views.Leaders.List


view : Model -> Html Msg
view model =
    div [ class "container-fluid", style [ ("height", "100vh") ] ] [
        nav [ class "navbar navbar-inverse bg-inverse", style [ ("height", "15vh"), ("padding", "0") ] ]
            [ a [ class "navbar-brand", href "#", style [("padding", "0")] ] 
                [ img [ style [("max-height", "15vh")],
                        src "http://seeklogo.com/images/E/elm-logo-9DEF2A830B-seeklogo.com.png" ] 
                    [] 
                ] 
            ],
        nav [ class "nav flex-column" , style [ ("width", "15%"), ("float", "left"), ("height", "85vh") ] ] [
            a [ class "nav-link", href "#" ] [ text "Our Leaders" ],
            a [ class "nav-link", href "#" ] [ text "Crime in States" ],
            a [ class "nav-link", href "#" ] [ text "Accidents in Cities" ],
            a [ class "nav-link", href "#" ] [ text "Our Rivers" ]
        ],
        div [ class "container bg-faded" , style [ ("width", "85%"), ("float", "left"), ("height", "85vh") ] ] [
            page model
        ]
    ]



page : Model -> Html Msg
page model =
    Views.Leaders.List.view model.leaders
