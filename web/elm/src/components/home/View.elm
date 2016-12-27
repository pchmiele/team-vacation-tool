module Components.Home.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Components.Home.Model as HomeModel exposing (..)
import Components.Home.Messages exposing (..)
import Components.SignIn.Model as SignInMsg


view : SignInMsg.Model -> HomeModel.Model -> Html Msg
view signInModel model =
    case signInModel.user of
        Nothing ->
            text ""

        _ ->
            div
                [ class "view-container boards index" ]
                [ text "asd"
                ]
