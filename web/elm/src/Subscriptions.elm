module Subscriptions exposing (..)

import Model exposing (..)
import Messages


subscriptions : Model.Model -> Sub Messages.Msg
subscriptions model =
    Sub.none
