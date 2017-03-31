module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { leaders : WebData (List Leader)
    }


initialModel : Model
initialModel =
    { leaders = RemoteData.Loading
    }


type alias Leader =
    { attendance : Float
    , name : String
    , state : String
    }
