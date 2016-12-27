module Components.SignUp.Model exposing (..)

import Material


type alias Model =
    { mdl : Material.Model
    , form : FormModel
    , error : Maybe String
    }


type alias FormModel =
    { email : String
    , password : String
    }


type alias LoginError =
    { email : Maybe String
    , password : Maybe String
    }


type alias Data =
    { id : String
    , email : String
    }


type alias SignUpResponseModel =
    { data : Data
    }


init : Model
init =
    { mdl = Material.model
    , form = FormModel "" ""
    , error = Nothing
    }
