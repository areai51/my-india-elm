module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Msgs exposing (Msg)
import Models exposing (Leader, River, Model)
import RemoteData


fetchLeaders : Cmd Msg
fetchLeaders =
    Http.get fetchLSLeadersUrl lsLeadersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchLSLeaders


fetchRivers : Cmd Msg
fetchRivers =
    Http.get fetchRiversUrl riversDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchRivers


fetchLSLeadersUrl : String
fetchLSLeadersUrl =
    "https://data.gov.in/node/85987/datastore/export/json"


fetchRSLeadersUrl : String
fetchRSLeadersUrl =
    "https://data.gov.in/node/982241/datastore/export/json"

fetchRiversUrl : String
fetchRiversUrl =
    "https://data.gov.in/api/datastore/resource.json?resource_id=2cfdb04a-e7e6-484b-8728-4cafbfe936e8&api-key=8064b14f9bd1e31d1e5a723a40b4fac1"


lsLeadersDecoder : Decode.Decoder (List Leader)
lsLeadersDecoder =
    Decode.at [ "data" ] (Decode.list leaderDecoder)


riversDecoder : Decode.Decoder (List River)
riversDecoder =
    Decode.at [ "records" ] (Decode.list riverDecoder)


leaderDecoder : Decode.Decoder Leader
leaderDecoder =
    let
        sessionsAttendedDecoder =
            Decode.index 7 Decode.float
                |> Decode.andThen (\total -> attendanceDecoder
                |> Decode.map (\attended -> (attended / total) * 100))
    in
        Decode.map3 Leader
            sessionsAttendedDecoder
            (Decode.index 2 Decode.string)
            (Decode.index 5 Decode.string)

attendanceDecoder : Decode.Decoder Float
attendanceDecoder =
    (Decode.oneOf
        [ Decode.index 8 Decode.float
        , Decode.succeed 0
        ]
    )

riverDecoder : Decode.Decoder River
riverDecoder =
    decode River
        |> required "STATE" Decode.string
        |> required "LOCATIONS" Decode.string
        |> required "TEMPERATUREInDegreeCentigradeMax" Decode.string
        |> required "TEMPERATUREInDegreeCentigradeMin" Decode.string
        |> required "PH6585Max" Decode.string
        |> required "PH6585Min" Decode.string
