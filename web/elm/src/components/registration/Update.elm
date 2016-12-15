module Components.Registration.Update exposing (..)

import Components.Registration.Model exposing (..)
import Components.Registration.View exposing (..)
import Components.Registration.Api exposing (..)
import Components.Registration.Messages exposing (..)
import Material
import Navigation
import Routing exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl mesessage ->
            Material.update mesessage model

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

        SignUp ->
            model ! [ signUp model ]

        SignUpResponse (Ok response) ->
            ( { model | error = Nothing }
            , Navigation.newUrl (toPath LoginNewRoute)
            )

        SignUpResponse (Err err) ->
            { model | error = (Just "Could not create user using providen email and password.") } ! []

        NavigateToLogin ->
            model ! [ Navigation.newUrl (toPath LoginNewRoute) ]
