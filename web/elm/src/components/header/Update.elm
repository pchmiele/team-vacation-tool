module Components.Header.Update exposing (..)

import Components.Header.Messages exposing (..)
import Components.Header.Model exposing (..)
import Material


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl message ->
            Material.update message model

        SignOut ->
            ( model, Cmd.none )
