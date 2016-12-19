module Components.Login.Update exposing (..)

import Components.Login.Model exposing (..)
import Components.Login.Api exposing (..)
import Components.Login.Messages exposing (..)
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
            { model | user = Just <| User model.form.email } ! [ auth model ]

        SignInResponse (Ok response) ->
            ( { model | error = Nothing, auth_token = Just response.data.token }
            , Navigation.newUrl (toPath HomeIndexRoute)
            )

        SignInResponse (Err err) ->
            { model | user = Nothing, error = (Just "Could not find user matching given email and password") } ! []

        NavigateToRegistration ->
            model ! [ Navigation.newUrl (toPath RegistrationNewRoute) ]

        SignOut ->
            { model | user = Nothing, auth_token = Nothing, form = emptyForm } ! [ Navigation.newUrl (toPath LoginNewRoute) ]
