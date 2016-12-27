module Components.SignIn.Decoder exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing ((|:))
import Components.SignIn.Model exposing (..)


tokenDecoder : Decoder Token
tokenDecoder =
    succeed Token
        |: (field "token" string)


signInDecoder : Decoder SignInResponseModel
signInDecoder =
    succeed SignInResponseModel |: (field "signin" tokenDecoder)
