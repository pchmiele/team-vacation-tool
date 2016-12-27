module Update exposing (..)

import Messages exposing (Msg(..))
import Model exposing (..)
import Components.SignIn.Update as SignIn
import Components.SignIn.Messages as SignInMessages
import Components.SignIn.Model as SignInModel
import Components.SignUp.Update as SignUp
import Components.SignUp.Messages as SignUpMessages
import Components.Home.Update as Home
import Components.Header.Update as Header
import Components.Header.Messages as HeaderMessages
import Routing exposing (parseLocation)
import Material


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        auth_token =
            model.auth_token
    in
        case msg of
            Mdl message ->
                Material.update message model

            HeaderMsg (HeaderMessages.SignOut) ->
                let
                    ( signIn, cmd ) =
                        SignIn.update SignInMessages.SignOut model.signIn
                in
                    { model | signIn = signIn, auth_token = Nothing } ! [ Cmd.map SignInMsg cmd ]

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

            SignInMsg subMsg ->
                let
                    ( signIn, cmd ) =
                        SignIn.update subMsg model.signIn
                in
                    { model | signIn = signIn, auth_token = signIn.auth_token } ! [ Cmd.map SignInMsg cmd ]

            SignUpMsg (SignUpMessages.SignUpResponse (Ok response)) ->
                let
                    previousSignIn =
                        model.signIn

                    form =
                        SignInModel.FormModel model.signUp.form.email model.signUp.form.password

                    ( signIn, cmd ) =
                        SignIn.update SignInMessages.SignIn { previousSignIn | form = form }
                in
                    { model | signIn = signIn, auth_token = Nothing } ! [ Cmd.map SignInMsg cmd ]

            SignUpMsg subMsg ->
                let
                    ( signUp, cmd ) =
                        SignUp.update subMsg model.signUp
                in
                    { model | signUp = signUp } ! [ Cmd.map SignUpMsg cmd ]

            OnLocationChange location ->
                let
                    newRoute =
                        parseLocation location
                in
                    ( { model | route = newRoute }, Cmd.none )
