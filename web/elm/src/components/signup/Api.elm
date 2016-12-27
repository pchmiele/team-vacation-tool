module Components.SignUp.Api exposing (..)

import Http exposing (..)
import Json.Encode as Encode
import Components.SignUp.Messages as SignUpMessages
import Components.SignUp.Decoder exposing (..)
import Components.SignUp.Model exposing (..)
import Graphql.Graphql as Graphql


signUp : Model -> Cmd SignUpMessages.Msg
signUp model =
    let
        params =
            model.form

        graphQLQuery =
            """mutation signup($email: String!, $password: String!) {signup(email: $email, password: $password) {id email}}"""

        graphQLParams =
            encodeParams params

        url =
            "/api/graphql"

        request =
            Graphql.mutation url graphQLQuery "signup" graphQLParams singUpResponseDecoder
    in
        Http.send SignUpMessages.SignUpResponse request


encodeParams : FormModel -> Encode.Value
encodeParams form =
    Encode.object
        [ ( "email", Encode.string form.email )
        , ( "password", Encode.string form.password )
        ]
