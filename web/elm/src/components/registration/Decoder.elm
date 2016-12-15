module Components.Registration.Decoder exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing ((|:))
import Components.Registration.Model exposing (..)


dataDecoder : Decode.Decoder Data
dataDecoder =
    succeed Data
        |: (field "id" int)
        |: (field "email" string)


singUpResponseDecoder : Decode.Decoder SignUpResponseModel
singUpResponseDecoder =
    succeed SignUpResponseModel
        |: (field "data" dataDecoder)
