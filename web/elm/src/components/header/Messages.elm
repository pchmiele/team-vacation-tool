module Components.Header.Messages exposing (..)

import Material


type Msg
    = Mdl (Material.Msg Msg)
    | SignOut
