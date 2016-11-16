module Tabs.Register exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Material
import Material.Textfield as Textfield
import Material.Button as Button
import Material.Options as Options exposing (nop)
import Task
import Http
import Json.Decode as Json
import Json.Decode.Pipeline as JsonPipeline
import Json.Encode as JS
import Register

main : Program Never
main =
    App.program
        { init = ( model, Cmd.none )
        , view = view False ""
        , subscriptions = always Sub.none
        , update = update
        }



-- CheckCredentials


checkCredentials : String -> String -> Cmd Msg
checkCredentials username password =
    let
        registerTask = httpCheckCredentials' username password
    in
        Task.perform RegisterFailed RegisterSucceed registerTask

httpCheckCredentials' : String -> String -> Task.Task Http.Error Register.RegisterResponse
httpCheckCredentials' username password =
    Http.send Http.defaultSettings
        { verb = "POST"
        , headers =
            [ ( "Content-Type", "application/json" )
            , ( "Accept", "application/json" )
            ]
        , url = "http://127.0.0.1:4000/api/users"
        , body =
            Http.string <| encodeRegisterRequest username password
        }
        |> Http.fromJson decodeRegisterResponse



-- Model


type alias Model =
    { email : String
    , password : String
    , authFailed : Bool
    , authorized : Bool
    , mdl : Material.Model
    }


model : Model
model =
    { email = ""
    , password = ""
    , authFailed = False
    , authorized = False
    , mdl = Material.model
    }



-- Update


type Msg
    = CheckCredentials
    | PasswordChange String
    | EmailChange String
    | MDL (Material.Msg Msg)
    | RegisterSucceed Register.RegisterResponse
    | RegisterFailed Http.Error
    | LoggedOut


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CheckCredentials ->
            ( model, checkCredentials model.email model.password )

        PasswordChange newPassword ->
            ( { model | password = newPassword }, Cmd.none )

        EmailChange newEmail ->
            ( { model | email = newEmail }, Cmd.none )

        RegisterSucceed registerResponse ->
            { model | authFailed = False, authorized = True } ! []

        RegisterFailed _ ->
            { model | authFailed = True } ! []

        MDL action' ->
            Material.update action' model

        LoggedOut ->
            { model | authorized = False } ! []



-- VIEW


view : Bool -> String -> Model -> Html Msg
view isRedirect targetTabName model =
    Options.div [ Options.css "margin-left" "20px" ]
        [ header
            [ style
                [ ( "text-align", "center" )
                , ( "margin-top", "4em" )
                ]
            ]
            [ h1
                [ style
                    [ ( "font-weight", "300" )
                    , ( "color", "#636363" )
                    ]
                ]
                [ text "Logon" ]
            , h3
                [ style
                    [ ( "font-weight", "300" )
                    , ( "color", "#4a89dc" )
                    ]
                ]
                [ text "Maintenance Tool in ELM" ]
            ]
        , renderForm isRedirect targetTabName model
        ]


renderForm : Bool -> String -> Model -> Html Msg
renderForm isRedirect targetTabName model =
    Html.form [ formCss, onSubmit CheckCredentials ]
        [ Options.div
            [ Options.center ]
            [ if model.authFailed then
                div []
                    [ text <|
                        "Access denied, invalid credentials"
                    , hr [] []
                    ]
                else
                text ""
            ]
        , Options.div
            [ Options.center ]
            [ if isRedirect then
                div []
                    [ text <|
                        "In order to access the "
                            ++ targetTabName
                            ++ " tab, you need to logon as an admin "
                    , hr [] []
                    ]
                else
                text ""
            ]
        , Options.div
            [ Options.center ]
            [ Textfield.render
                MDL
                [ 0 ]
                model.mdl
                [ Textfield.label "Email"
                , Textfield.floatingLabel
                , Textfield.autofocus
                , Textfield.value model.email
                , Textfield.onInput EmailChange
                , Textfield.text'
                ]
            ]
        , Options.div
            [ Options.center ]
            [ Textfield.render
                MDL
                [ 1 ]
                model.mdl
                [ Textfield.label "Password"
                , Textfield.floatingLabel
                , Textfield.onInput PasswordChange
                , Textfield.password
                ]
            ]
        , Options.div
            [ Options.center ]
            [ Button.render
                MDL
                [ 2 ]
                model.mdl
                [ Button.raised
                , Button.colored
                , Button.onClick CheckCredentials
                ]
                [ text "Register" ]
            ]
        ]


-- Json encode /decode


encodeRegisterRequest : String -> String -> String
encodeRegisterRequest email password =
    JS.encode 0 <|
        JS.object
            [ ( "email", JS.string email )
            , ( "password", JS.string password )
            ]


decodeRegisterResponse : Json.Decoder Register.RegisterResponse
decodeRegisterResponse =
    JsonPipeline.decode Register.RegisterResponse
        |> JsonPipeline.required "id" Json.string
        |> JsonPipeline.required "email" Json.string

formCss =
    style
        [ ( "width", "380px" )
        , ( "margin", "4em auto" )
        , ( "padding", "3em 2em 2em 2em" )
        , ( "background", "#fafafa" )
        , ( "border", "1px solid #ebebeb" )
        , ( "box-shadow", "rgba(0,0,0,0.14902) 0px 1px 1px 0px,rgba(0,0,0,0.09804) 0px 1px 2px 0px" )
        ]
