module Components.Header.View exposing (..)

import Html exposing (..)
import Components.Header.Model exposing (..)
import Components.Header.Messages exposing (..)
import Material.Layout as Layout
import Components.SignIn.Model as SignIn
import Material.Icon as Icon
import Material.Menu as Menu


view : SignIn.Model -> Model -> Html Msg
view signIn model =
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
                [ text <| userName signIn ]
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


userName : SignIn.Model -> String
userName signInModel =
    let
        user =
            Maybe.withDefault (SignIn.User "") signInModel.user
    in
        user.email
