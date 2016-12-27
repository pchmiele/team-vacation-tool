module Components.SignIn.Messages exposing (..)

import Material
import Http
import Components.SignIn.Model exposing (..)


type Msg
    = Mdl (Material.Msg Msg)
    | HandleEmailInput String
    | HandlePasswordInput String
    | SignIn
    | SignInResponse (Result Http.Error SignInResponseModel)
    | NavigateToSignUp
    | SignOut
