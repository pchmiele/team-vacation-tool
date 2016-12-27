module Model exposing (..)

import Material
import Routing exposing (..)
import Components.Home.Model as Home
import Components.Header.Model as Header
import Components.SignIn.Model as SignIn
import Components.SignUp.Model as SignUp


type alias Model =
    { mdl : Material.Model
    , route : Route
    , header : Header.Model
    , home : Home.Model
    , signIn : SignIn.Model
    , signUp : SignUp.Model
    , auth_token : Maybe String
    }


type alias ErrorModel =
    { error : String }


initialModel : Maybe String -> Routing.Route -> Model
initialModel auth_token route =
    { mdl = Material.model
    , route = route
    , header = Header.initialModel
    , home = Home.initialModel
    , signIn = SignIn.init auth_token
    , signUp = SignUp.init
    , auth_token = auth_token
    }
