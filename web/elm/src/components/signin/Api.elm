module Components.SignIn.Api exposing (signIn)

import Http exposing (..)
import Json.Encode as Encode
import Components.SignIn.Messages as SignInMessages
import Components.SignIn.Decoder exposing (signInDecoder)
import Components.SignIn.Model exposing (..)
import Graphql.Graphql as Graphql


signIn : Model -> Cmd SignInMessages.Msg
signIn model =
    let
        params =
            model.form

        graphQLQuery =
            """mutation signin($email: String!, $password: String!) { signin(email: $email, password: $password) { token } }"""

        graphQLParams =
            encodeParams params

        url =
            "/api/graphql"

        request =
            Graphql.mutation url graphQLQuery "signin" graphQLParams signInDecoder
    in
        Http.send SignInMessages.SignInResponse request


encodeParams : FormModel -> Encode.Value
encodeParams form =
    Encode.object
        [ ( "email", Encode.string form.email )
        , ( "password", Encode.string form.password )
        ]
