module Components.SignUp.Decoder exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing ((|:))
import Components.SignUp.Model exposing (..)


userDecoder : Decode.Decoder Data
userDecoder =
    succeed Data
        |: (field "id" string)
        |: (field "email" string)


singUpResponseDecoder : Decode.Decoder SignUpResponseModel
singUpResponseDecoder =
    succeed SignUpResponseModel
        |: (field "signup" userDecoder)
