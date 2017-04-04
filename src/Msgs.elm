module Msgs exposing (..)

import Models exposing (Leader)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchLSLeaders (WebData (List Leader))
    | OnFetchRSLeaders (WebData (List Leader))
    | OnLocationChange Location
