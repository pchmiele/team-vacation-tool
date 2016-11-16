module Register exposing (RegisterResponse, none)

type alias RegisterResponse =
    { id : String
    , email : String
    }

none : RegisterResponse
none =
    RegisterResponse "" ""
