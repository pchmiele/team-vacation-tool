module Main exposing (..)

import Navigation
import View exposing (view)
import Model exposing (..)
import Messages exposing (..)
import Update exposing (..)
import Routing exposing (Route)
import Routing exposing (..)
import Subscriptions exposing (..)
import Components.SignIn.Model as SignIn


init : Navigation.Location -> ( Model, Cmd Messages.Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location

        model =
            initialModel Nothing SignInRoute
    in
        ( model, Cmd.none )


authenticationCheck : SignIn.Model -> Cmd Messages.Msg
authenticationCheck signIn =
    case signIn.user of
        Nothing ->
            case signIn.auth_token of
                Nothing ->
                    Navigation.newUrl (toPath SignInRoute)

                Just auth_token ->
                    Navigation.newUrl (toPath SignInRoute)

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
