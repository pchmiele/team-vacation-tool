module Messages exposing (..)

import Material
import Navigation exposing (Location)
import Components.Home.Messages as Home
import Components.Header.Messages as Header
import Components.Login.Messages as Login
import Components.Registration.Messages as Registration


type Msg
    = Mdl (Material.Msg Msg)
    | HomeMsg Home.Msg
    | HeaderMsg Header.Msg
    | LoginMsg Login.Msg
    | RegistrationMsg Registration.Msg
    | OnLocationChange Location
