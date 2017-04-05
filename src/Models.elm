module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { lsLeaders : WebData (List Leader)
    , rsLeaders : WebData (List Leader)
    , rivers : WebData (List River)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { lsLeaders = RemoteData.Loading
    , rsLeaders = RemoteData.Loading
    , rivers = RemoteData.Loading
    , route = route
    }


type alias Leader =
    { attendance : Float
    , name : String
    , state : String
    }

type alias River =
    { state : String
    , location : String
    , maxTemp : String
    , minTemp : String
    , maxPH : String
    , minPH : String
    }


type Route
    = LeadersRoute
    | StateCrimesRoute
    | CityAccidentsRoutes
    | RiversRoute
    | NotFoundRoute