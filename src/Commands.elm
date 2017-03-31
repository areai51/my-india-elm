module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Msgs exposing (Msg)
import Models exposing (Leader, Model)
import RemoteData


fetchLeaders : Cmd Msg
fetchLeaders =
    Http.get fetchLeadersUrl leadersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchLeaders


fetchLeadersUrl : String
fetchLeadersUrl =
      "http://localhost:4000/leaders"
    --"https://data.gov.in/node/85987/datastore/export/json"


leadersDecoder : Decode.Decoder (List Leader)
leadersDecoder =
    Decode.list leaderDecoder


leaderDecoder : Decode.Decoder Leader
leaderDecoder =
    decode Leader
        |> optional "attendance" Decode.float 0
        |> required "name" Decode.string
        |> required "state" Decode.string
