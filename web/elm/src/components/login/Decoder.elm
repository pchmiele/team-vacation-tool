module Components.Login.Decoder exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Decode.Extra exposing ((|:))
import Components.Login.Model exposing (..)


dataDecoder : Decode.Decoder Data
dataDecoder =
    succeed Data
        |: (field "token" string)


authResponseDecoder : Decode.Decoder SignInResponseModel
authResponseDecoder =
    succeed SignInResponseModel
        |: (field "data" dataDecoder)
