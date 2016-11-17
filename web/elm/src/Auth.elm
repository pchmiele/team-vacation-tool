module Auth exposing (Data, Response, Info, none)

type alias Data = 
    {
        token: String
    }

type alias Response =
    { 
        data: Data
    }

type alias Info = 
    {
        username: String,
        token: String
    }

emptyData : Data
emptyData = 
    Data ""

none : Response
none =
    Response emptyData