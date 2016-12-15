module Components.Home.Update exposing (..)

import Navigation exposing (..)
import Routing exposing (..)
import Components.Home.Messages exposing (..)
import Components.Home.Model exposing (..)
import Material


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl mesessage ->
            Material.update mesessage model

        NavigateToHome ->
            model ! [ Navigation.newUrl (toPath HomeIndexRoute) ]
