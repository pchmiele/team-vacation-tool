module Tabs.Logon exposing (Model, Msg(PostFail, PostSucceed, LoggedOut), model, update, view)

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
import Auth


main : Program Never
main =
    App.program
        { init = ( model, Cmd.none )
        , view = view False ""
        , subscriptions = always Sub.none
        , update = update
        }


-- CheckCredentials

toAuthInfo : String -> Auth.Response -> Auth.Info
toAuthInfo username response =
    Auth.Info username response.data.token

checkCredentials : String -> String -> Cmd Msg
checkCredentials username password =
    let
        authTask = httpCheckCredentials' username password
    in
        Task.perform PostFail PostSucceed authTask


httpCheckCredentials' : String -> String -> Task.Task Http.Error Auth.Info
httpCheckCredentials' username password =
    let 
        response = Http.send Http.defaultSettings
            { verb = "POST"
            , headers =
                [ ( "Content-Type", "application/json" )
                , ( "Accept", "application/json" )
                ]
            , url = "http://127.0.0.1:4000/api/sessions"
            , body =
                Http.string <| encodeAuthRequest username password
            }
            |> Http.fromJson decodeAuthResponse
    in
        Task.map (toAuthInfo username) response

-- Model


type alias Model =
    { username : String
    , password : String
    , authFailed : Bool
    , authorized : Bool
    , mdl : Material.Model
    }


model : Model
model =
    { username = ""
    , password = ""
    , authFailed = False
    , authorized = False
    , mdl = Material.model
    }



-- Update


type Msg
    = CheckCredentials
    | PasswordChange String
    | UsernameChange String
    | MDL (Material.Msg Msg)
    | PostSucceed Auth.Info
    | PostFail Http.Error
    | LoggedOut


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CheckCredentials ->
            ( model, checkCredentials model.username model.password )

        PasswordChange newPassword ->
            ( { model | password = newPassword }, Cmd.none )

        UsernameChange newUsername ->
            ( { model | username = newUsername }, Cmd.none )

        PostSucceed userAuth ->
            { model | authFailed = False, authorized = True } ! []

        PostFail _ ->
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
        , renderFormIfNotLogged isRedirect targetTabName model
        ]


renderFormIfNotLogged : Bool -> String -> Model -> Html Msg
renderFormIfNotLogged isRedirect targetTabName model =
    if not model.authorized then
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
                                ++ " tab, you need to logon as a user in the "
                                ++ " role."
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
                    [ Textfield.label "Username"
                    , Textfield.floatingLabel
                    , Textfield.autofocus
                    , Textfield.value model.username
                    , Textfield.onInput UsernameChange
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
                    ]
                    [ text "Login" ]
                ]
            ]
    else
        h3
            [ style
                [ ( "text-align", "center" )
                , ( "margin-top", "1em" )
                ]
            ]
            [ text "Successfuly logged in, welcome!" ]



-- Json encode /decode


encodeAuthRequest : String -> String -> String
encodeAuthRequest email password =
    JS.encode 0 <|
        JS.object
            [ 
                ( "user", JS.object 
                [ ( "email", JS.string email )
                , ( "password", JS.string password )
                ])
            ]

decodeAuthResponse : Json.Decoder Auth.Response
decodeAuthResponse =
        JsonPipeline.decode Auth.Response
            |> JsonPipeline.required "data" decodeAuthData

decodeAuthData : Json.Decoder Auth.Data
decodeAuthData =
    JsonPipeline.decode Auth.Data
        |> JsonPipeline.required "token" Json.string
        
formCss =
    style
        [ ( "width", "380px" )
        , ( "margin", "4em auto" )
        , ( "padding", "3em 2em 2em 2em" )
        , ( "background", "#fafafa" )
        , ( "border", "1px solid #ebebeb" )
        , ( "box-shadow", "rgba(0,0,0,0.14902) 0px 1px 1px 0px,rgba(0,0,0,0.09804) 0px 1px 2px 0px" )
        ]
