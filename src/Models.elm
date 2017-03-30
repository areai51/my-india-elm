module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model =
    { leaders : List Leader
    }


initialModel : Model
initialModel =
    { leaders = [ Leader 12 "name" "state" ]
    }


type alias Leader =
    { attendance : Int
    , name : String
    , state : String
    }
