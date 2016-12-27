module Components.SignIn.Model exposing (..)

import Material


type alias Mdl =
    Material.Model


type alias User =
    { email : String
    }


type alias Model =
    { mdl : Material.Model
    , form : FormModel
    , error : Maybe String
    , auth_token : Maybe String
    , user : Maybe User
    }


type alias FormModel =
    { email : String
    , password : String
    }


type alias SignInError =
    { email : Maybe String
    , password : Maybe String
    }


type alias Token =
    { token : String
    }


type alias SignInResponseModel =
    { signin : Token
    }


type alias SignOutResponseModel =
    { status : String
    }


emptyForm : FormModel
emptyForm =
    FormModel "" ""


init : Maybe String -> Model
init auth_token =
    { mdl = Material.model
    , form = emptyForm
    , error = Nothing
    , auth_token = auth_token
    , user = Nothing
    }
