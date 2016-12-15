module Components.Registration.Messages exposing (..)

import Material
import Http
import Components.Registration.Model exposing (..)


type Msg
    = Mdl (Material.Msg Msg)
    | HandleEmailInput String
    | HandlePasswordInput String
    | SignUp
    | SignUpResponse (Result Http.Error SignUpResponseModel)
    | NavigateToLogin
