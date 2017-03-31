module Msgs exposing (..)

import Models exposing (Leader)
import RemoteData exposing (WebData)


type Msg
    = OnFetchLeaders (WebData (List Leader))
