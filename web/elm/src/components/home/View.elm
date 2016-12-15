module Components.Home.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.Home.Model as HomeModel exposing (..)
import Components.Home.Messages exposing (..)
import Components.Login.Model as LoginModel


view : LoginModel.Model -> HomeModel.Model -> Html Msg
view loginModel model =
    case loginModel.user of
        Nothing ->
            text ""

        _ ->
            div
                [ class "view-container boards index" ]
                [ text "asd"
                ]
