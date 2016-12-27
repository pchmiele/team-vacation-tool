module Components.SignIn.Update exposing (..)

import Components.SignIn.Model exposing (..)
import Components.SignIn.Api exposing (..)
import Components.SignIn.Messages exposing (..)
import Material
import Navigation
import Routing exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl message ->
            Material.update message model

        HandlePasswordInput new_password ->
            let
                form =
                    model.form
            in
                { model | form = { form | password = new_password } } ! []

        HandleEmailInput new_email ->
            let
                form =
                    model.form
            in
                { model | form = { form | email = new_email } } ! []

        SignIn ->
            { model | user = Just <| User model.form.email } ! [ signIn model ]

        SignInResponse (Ok response) ->
            ( { model | error = Nothing, auth_token = Just response.signin.token }
            , Navigation.newUrl (toPath HomeIndexRoute)
            )

        SignInResponse (Err err) ->
            let
                _ =
                    Debug.log "debug" err
            in
                { model | user = Nothing, error = (Just "Could not find user matching given email and password") } ! []

        NavigateToSignUp ->
            model ! [ Navigation.newUrl (toPath SignUpRoute) ]

        SignOut ->
            { model | user = Nothing, auth_token = Nothing, form = emptyForm } ! [ Navigation.newUrl (toPath SignInRoute) ]
