module Update exposing (..)

import Messages exposing (Msg(..))
import Model exposing (..)
import Components.Login.Update as Login
import Components.Registration.Update as Registration
import Components.Home.Update as Home
import Components.Header.Update as Header
import Components.Header.Messages as HeaderMessages
import Components.Login.Messages as LoginMessages
import Routing exposing (parseLocation)
import Material


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        auth_token =
            model.auth_token
    in
        case msg of
            Mdl mesessage ->
                Material.update mesessage model

            HeaderMsg (HeaderMessages.SignOut) ->
                let
                    ( login, cmd ) =
                        Login.update LoginMessages.SignOut model.login
                in
                    { model | login = login, auth_token = Nothing } ! [ Cmd.map LoginMsg cmd ]

            HeaderMsg subMsg ->
                let
                    ( header, cmd ) =
                        Header.update subMsg model.header
                in
                    { model | header = header } ! [ Cmd.map HeaderMsg cmd ]

            HomeMsg subMsg ->
                let
                    ( home, cmd ) =
                        Home.update subMsg model.home
                in
                    { model | home = home } ! [ Cmd.map HomeMsg cmd ]

            LoginMsg subMsg ->
                let
                    ( login, cmd ) =
                        Login.update subMsg model.login
                in
                    { model | login = login, auth_token = login.auth_token } ! [ Cmd.map LoginMsg cmd ]

            RegistrationMsg subMsg ->
                let
                    ( registration, cmd ) =
                        Registration.update subMsg model.registration
                in
                    { model | registration = registration } ! [ Cmd.map RegistrationMsg cmd ]

            OnLocationChange location ->
                let
                    newRoute =
                        parseLocation location
                in
                    ( { model | route = newRoute }, Cmd.none )
