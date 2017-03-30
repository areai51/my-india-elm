module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (Leader)
import RemoteData


fetchLeaders : Cmd Msg
fetchLeaders =
    Http.get fetchLeadersUrl leadersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchLeaders


fetchLeadersUrl : String
fetchLeadersUrl =
    "https://data.gov.in/node/85987/datastore/export/json"


leadersDecoder : Decode.Decoder (List Leader)
leadersDecoder =
    Decode.list leaderDecoder


leaderDecoder : Decode.Decoder Leader
leaderDecoder =
    decode Leader
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int
