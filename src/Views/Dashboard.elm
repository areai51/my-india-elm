module Views.Dashboard exposing (..)

import Html exposing (Html, div, text, nav, img, a, button, ul, li, article, header, section)
import Html.Attributes exposing (class, href, src, height, width, style, alt)
import Msgs exposing (Msg)
import Models exposing (Model)
import Views.Leaders
import Views.Accidents
import Views.Crimes
import Views.Rivers
import Routing exposing (leadersPath, crimesPath, accidentsPath, riversPath)


view : Model -> Html Msg
view model =
    div [ style [ ("height", "100%"), ("width", "100%") ] ] [
        div [ class "side-bar" ]
            [ a [ class "site-logo", href "#" ]
                    [ img [ alt "My India Logo", src "site-logo.png" ]
                        []
                    ]
                , nav [ class "main-nav" ]
                    [ ul []
                        [ li []
                            [ a [ class "nav-link", href leadersPath ] [ text "Our Leaders" ]
                            ]
                        , li []
                            [ a [ class "nav-link", href crimesPath ] [ text "Crime in States" ]
                            ]
                        , li []
                            [ a [ class "nav-link", href accidentsPath ] [ text "Accidents in Cities" ]
                            ]
                        , li []
                            [ a [ class "nav-link", href riversPath ] [ text "Our Rivers" ]
                            ]
                        ]
                    ]
            ],
        section [ class "col-10" ]
            [ header []
                []
            , article [ class "main-container" ]
                [ page model ]
            ]
    ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.LeadersRoute ->
            Views.Leaders.view model.lsLeaders model.rsLeaders

        Models.StateCrimesRoute ->
            Views.Crimes.view

        Models.CityAccidentsRoutes ->
            Views.Accidents.view

        Models.RiversRoute ->
            Views.Rivers.view model.rivers

        Models.NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
