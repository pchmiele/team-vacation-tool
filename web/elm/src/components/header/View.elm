module Components.Header.View exposing (..)

import Html exposing (..)
import Components.Header.Model exposing (..)
import Components.Header.Messages exposing (..)
import Material.Layout as Layout
import Components.Login.Model as Login
import Material.Icon as Icon
import Material.Menu as Menu


view : Login.Model -> Model -> Html Msg
view loginModel model =
    Layout.row
        []
        [ Layout.title [] [ text "Team Vacation Tool" ]
        , Layout.spacer
        , Layout.navigation []
            [ Layout.link
                []
                [ Icon.i "account_circle" ]
            , Layout.link
                []
                [ text <| userName loginModel ]
            , menu model
            ]
        ]


menu : Model -> Html Msg
menu model =
    Menu.render Mdl
        [ 0 ]
        model.mdl
        [ Menu.ripple, Menu.bottomRight ]
        [ Menu.item
            []
            [ text "Settings" ]
        , Menu.item
            [ Menu.onSelect SignOut ]
            [ text "Logout" ]
        ]


userName : Login.Model -> String
userName loginModel =
    let
        user =
            Maybe.withDefault (Login.User "") loginModel.user
    in
        user.email
