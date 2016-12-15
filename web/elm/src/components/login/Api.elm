module Components.Login.Api exposing (..)

import Http exposing (..)
import Json.Encode as Encode
import Components.Login.Messages as LoginMessages
import Components.Login.Decoder exposing (..)
import Components.Login.Model exposing (..)


auth : Model -> Cmd LoginMessages.Msg
auth model =
    let
        request =
            Http.request
                { method = "POST"
                , headers = []
                , url = "http://127.0.0.1:4000/api/rest/sessions"
                , body = jsonBody (userEncoder model.form)
                , expect = expectJson authResponseDecoder
                , timeout = Nothing
                , withCredentials = False
                }
    in
        Http.send LoginMessages.SignInResponse request


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
