module Main exposing (..)

import Msgs exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import Navigation exposing (Location)
import Routing
import Views.Dashboard exposing (view)
import Commands exposing (fetchLSLeaders, fetchRSLeaders)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( initialModel currentRoute, Cmd.batch [ fetchLSLeaders, fetchRSLeaders ] )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- MAIN

main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
