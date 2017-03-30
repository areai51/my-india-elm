module Msgs exposing (..)

import Models exposing (Leader)
import RemoteData exposing (WebData)


type Msg
    = NoOp
    --OnFetchPlayers (WebData (List Leader))