module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (..)
import Messages exposing (..)
import Routing exposing (..)
import Components.SignIn.View as SignInView
import Components.SignUp.View as SignUpView
import Components.Home.View as HomeView
import Components.Header.View as HeaderView
import Material.Layout as Layout
import Material.Options as Options


view : Model -> Html Messages.Msg
view model =
    Layout.render Mdl
        model.mdl
        []
        { header = header model
        , drawer = []
        , tabs = ( [], [] )
        , main = [ body model ]
        }


header : Model -> List (Html Messages.Msg)
header model =
    case model.auth_token of
        Just token ->
            [ Html.map HeaderMsg (HeaderView.view model.signIn model.header) ]

        Nothing ->
            []


body : Model -> Html Messages.Msg
body model =
    let
        bodyContent =
            case model.route of
                HomeIndexRoute ->
                    Html.map HomeMsg (HomeView.view model.signIn model.home)

                SignInRoute ->
                    Html.map SignInMsg (SignInView.view model.signIn)

                SignUpRoute ->
                    Html.map SignUpMsg (SignUpView.view model.signUp)

                _ ->
                    notFoundView
    in
        Options.div
            [ Options.center
            ]
            [ bodyContent ]


notFoundView : Html Messages.Msg
notFoundView =
    div
        [ id "error_index" ]
        [ div
            [ class "warning" ]
            [ span
                [ class "fa-stack" ]
                [ i [ class "fa fa-meh-o fa-stack-2x" ] [] ]
            , h4 [] [ text "404" ]
            ]
        ]
