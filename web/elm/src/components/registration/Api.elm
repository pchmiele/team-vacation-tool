module Components.Registration.Api exposing (..)

import Http exposing (..)
import Json.Encode as Encode
import Components.Registration.Messages as RegisterMessages
import Components.Registration.Decoder exposing (..)
import Components.Registration.Model exposing (..)


signUp : Model -> Cmd RegisterMessages.Msg
signUp model =
    let
        request =
            Http.request
                { method = "POST"
                , headers = []
                , url = "http://127.0.0.1:4000/api/rest/users"
                , body = jsonBody (userEncoder model.form)
                , expect = expectJson singUpResponseDecoder
                , timeout = Nothing
                , withCredentials = False
                }
    in
        Http.send RegisterMessages.SignUpResponse request


userEncoder : FormModel -> Encode.Value
userEncoder form =
    Encode.object
        [ ( "user"
          , Encode.object
                [ ( "email", Encode.string form.email )
                , ( "password", Encode.string form.password )
                ]
          )
        ]
