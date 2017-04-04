module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { lsLeaders : WebData (List Leader)
    , rsLeaders : WebData (List Leader)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { lsLeaders = RemoteData.Loading
    , rsLeaders = RemoteData.Loading
    , route = route
    }


type alias Leader =
    { attendance : Float
    , name : String
    , state : String
    }


type Route
    = LeadersRoute
    | StateCrimesRoute
    | CityAccidentsRoutes
    | RiversRoute
    | NotFoundRoute