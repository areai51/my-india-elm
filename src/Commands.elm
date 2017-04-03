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
    --"http://localhost:4000/leaders"
    "https://data.gov.in/node/85987/datastore/export/json"


leadersDecoder : Decode.Decoder (List Leader)
leadersDecoder =
    --Decode.list leaderDecoder
    Decode.at [ "data" ] (Decode.list leaderDecoder)


leaderDecoder : Decode.Decoder Leader
leaderDecoder =
    {-decode Leader
        |> optional "attendance" Decode.float 0
        |> required "name" Decode.string
        |> required "state" Decode.string-}
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
