module Main exposing (..)

import Navigation
import View exposing (view)
import Model exposing (..)
import Messages exposing (..)
import Update exposing (..)
import Routing exposing (Route)
import Routing exposing (..)
import Subscriptions exposing (..)
import Components.Login.Model as Login


init : Navigation.Location -> ( Model, Cmd Messages.Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location

        model =
            initialModel Nothing LoginNewRoute
    in
        ( model, Cmd.none )


authenticationCheck : Login.Model -> Cmd Messages.Msg
authenticationCheck login =
    case login.user of
        Nothing ->
            case login.auth_token of
                Nothing ->
                    Navigation.newUrl (toPath LoginNewRoute)

                Just auth_token ->
                    Navigation.newUrl (toPath LoginNewRoute)

        Just user ->
            Cmd.none


main : Program Never Model Messages.Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
