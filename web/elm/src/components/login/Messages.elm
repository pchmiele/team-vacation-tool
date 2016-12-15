module Components.Login.Messages exposing (..)

import Material
import Http
import Components.Login.Model exposing (..)


type Msg
    = Mdl (Material.Msg Msg)
    | HandleEmailInput String
    | HandlePasswordInput String
    | SignIn
    | SignInResponse (Result Http.Error SignInResponseModel)
    | NavigateToRegistration
    | SignOut
