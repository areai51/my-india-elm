module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map LeadersRoute top
        , map LeadersRoute (s "leaders")
        , map StateCrimesRoute (s "crimes")
        , map CityAccidentsRoutes (s "accidents")
        , map RiversRoute (s "rivers")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

leadersPath : String
leadersPath =
    "#leaders"

crimesPath : String
crimesPath =
    "#crimes"

accidentsPath : String
accidentsPath =
    "#accidents"

riversPath : String
riversPath =
    "#rivers"
