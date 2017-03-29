module Models exposing (..)


type alias Model =
    { leaders : List Leader
    }


initialModel : Model
initialModel =
    { leaders = [ Leader 100 "Sam" "MH" ]
    }


type alias Leader =
    { attendance : Int
    , name : String
    , state : String
    }
