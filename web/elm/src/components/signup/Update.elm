module Components.SignUp.Update exposing (..)

import Components.SignUp.Model exposing (..)
import Components.SignUp.Api exposing (..)
import Components.SignUp.Messages exposing (..)
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

        SignUp ->
            model ! [ signUp model ]

        SignUpResponse (Ok response) ->
            ( { model | error = Nothing }
            , Navigation.newUrl (toPath SignInRoute)
            )

        SignUpResponse (Err err) ->
            { model | error = (Just "Could not create user using providen email and password.") } ! []

        NavigateToSignIn ->
            model ! [ Navigation.newUrl (toPath SignInRoute) ]
