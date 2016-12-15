module Model exposing (..)

import Material
import Routing exposing (..)
import Components.Home.Model as Home
import Components.Header.Model as Header
import Components.Login.Model as Login
import Components.Registration.Model as Registration


type alias Model =
    { mdl : Material.Model
    , route : Route
    , header : Header.Model
    , home : Home.Model
    , login : Login.Model
    , registration : Registration.Model
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
    , login = Login.init auth_token
    , registration = Registration.init
    , auth_token = auth_token
    }
