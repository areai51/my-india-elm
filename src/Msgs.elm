module Msgs exposing (..)

import Models exposing (Leader, River)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchLSLeaders (WebData (List Leader))
    | OnFetchRSLeaders (WebData (List Leader))
    | OnFetchRivers (WebData (List River))
    | OnLocationChange Location
