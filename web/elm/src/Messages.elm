module Messages exposing (..)

import Material
import Navigation exposing (Location)
import Components.Home.Messages as Home
import Components.Header.Messages as Header
import Components.SignIn.Messages as SignIn
import Components.SignUp.Messages as SignUp


type Msg
    = Mdl (Material.Msg Msg)
    | HomeMsg Home.Msg
    | HeaderMsg Header.Msg
    | SignInMsg SignIn.Msg
    | SignUpMsg SignUp.Msg
    | OnLocationChange Location
