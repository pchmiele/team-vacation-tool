module Components.SignUp.Messages exposing (..)

import Material
import Http
import Components.SignUp.Model exposing (..)


type Msg
    = Mdl (Material.Msg Msg)
    | HandleEmailInput String
    | HandlePasswordInput String
    | SignUp
    | SignUpResponse (Result Http.Error SignUpResponseModel)
    | NavigateToSignIn
