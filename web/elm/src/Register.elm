module Register exposing (RegisterResponse, Data, none)

type alias Data = 
    { id : Int
    , email : String
    }


type alias RegisterResponse =
    { data: Data
    }

emptyData : Data
emptyData = 
    Data 0 ""

none : RegisterResponse
none =
    RegisterResponse emptyData