module Components.SignIn.View exposing (..)

import Components.SignIn.Model exposing (..)
import Components.SignIn.Messages exposing (..)
import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Material.Button as Button
import Material.Options exposing (css)
import Material.Textfield as Textfield
import Material.Options as Options
import Material.Typography as Typo
import Material.Options as Options
import Html exposing (p)
import Html.Events exposing (..)


view : Model -> Html Msg
view model =
    Options.div
        [ Options.css "width" "420px"
        , Options.css "margin" "2em 2em 2em 2em"
        ]
        [ Html.form [ form_css, onSubmit SignIn ]
            [ Options.styled p
                [ Typo.headline
                , Typo.center
                ]
                [ text "Log in" ]
            , errorView model.error
            , Options.div
                [ Options.center ]
                [ Textfield.render
                    Mdl
                    [ 0 ]
                    model.mdl
                    [ Textfield.label "Email"
                    , Textfield.autofocus
                    , Textfield.onInput HandleEmailInput
                    , Textfield.text_
                    ]
                ]
            , Options.div
                [ Options.center ]
                [ Textfield.render
                    Mdl
                    [ 1 ]
                    model.mdl
                    [ Textfield.label "Password"
                    , Textfield.onInput HandlePasswordInput
                    , Textfield.password
                    ]
                ]
            , Options.div
                [ Options.css "margin" "2em 0em 0em 0em"
                ]
                [ Button.render
                    Mdl
                    [ 2 ]
                    model.mdl
                    [ Button.raised
                    , Button.colored
                    , Options.css "width" "100%"
                    , Options.css "background" "#2196F3"
                    ]
                    [ text "Log in" ]
                ]
            ]
        , Options.div
            [ Options.center ]
            [ text "Don't have an account?"
            , Button.render
                Mdl
                [ 2 ]
                model.mdl
                [ Button.plain
                , Button.flat
                , Button.onClick NavigateToSignUp
                ]
                [ text "Sign Up" ]
            ]
        ]


form_css : Attribute Msg
form_css =
    style
        [ ( "width", "380px" )
        , ( "padding", "3em 2em 2em 2em" )
        , ( "margin", "1em 1em 1em 1em" )
        , ( "background", "#fafafa" )
        , ( "border", "1px solid #ebebeb" )
        , ( "box-shadow", "rgba(0,0,0,0.14902) 0px 1px 1px 0px,rgba(0,0,0,0.09804) 0px 1px 2px 0px" )
        ]


errorView : Maybe String -> Html Msg
errorView maybeError =
    Options.styled p
        [ Typo.center
        , Options.css "color" "red"
        , Options.css "font-size" "10"
        ]
        [ case maybeError of
            Just error ->
                text error

            Nothing ->
                text ""
        ]
