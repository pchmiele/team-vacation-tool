module Main exposing (main)

import Html.App as App
import Html exposing (..)
import Material
import Material.Scheme
import Material.Color as Color
import Material.Options as Options exposing (css, when)
import Material.Typography as Typography
import Material.Button as Button
import Material.Layout as Layout
import Material.Helpers exposing (lift)
import Navigation
import RouteUrl as Routing
import Tabs.Puppies
import Tabs.Tables
import Tabs.Logon
import Tabs.Monitoring
import Tabs.Monitoring as GetTime exposing (Msg(GetTime))
import Tabs.Register
import Array exposing (Array)
import Dict exposing (Dict)
import String
import Utils

-- MODEL


type alias Model =
    { selectedTab : Int
    , username : Maybe String
    , authToken : Maybe String
    , desiredTab : Int
    , tabPuppies : Tabs.Puppies.Model
    , tabTables : Tabs.Tables.Model
    , tabLogon : Tabs.Logon.Model
    , tabRegister: Tabs.Register.Model
    , tabMonitoring : Tabs.Monitoring.Model
    , tabInfoArray : Array TabInfo
    , mdl : Material.Model
    }


model : Model
model =
    { mdl = Material.model
    , selectedTab = 0
    , desiredTab = 0
    , username = Nothing
    , authToken = Nothing
    , tabPuppies = Tabs.Puppies.model
    , tabTables = Tabs.Tables.model
    , tabLogon = Tabs.Logon.model
    , tabRegister = Tabs.Register.model
    , tabMonitoring = Tabs.Monitoring.model
    , tabInfoArray = tabInfoArray
    }


-- ACTION, UPDATE


type Msg
    = Mdl (Material.Msg Msg)
    | PuppiesMsg Tabs.Puppies.Msg
    | TablesMsg Tabs.Tables.Msg
    | MonitoringMsg Tabs.Monitoring.Msg
    | LogonMsg Tabs.Logon.Msg
    | RegisterMsg Tabs.Register.Msg
    | SelectTab Int
    | LogoutMsg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectTab tab ->
            if isAuthenticated model then
                ( { model
                    | selectedTab = tab + 2
                    , desiredTab = tab + 2
                    }
                , Cmd.none
                )
            else
                ( { model
                    | selectedTab = if tab < 2 then tab else 0
                    , desiredTab = tab
                    }
                , Cmd.none
                )

        LogonMsg childMsg ->
            let
                ( ourModel, ourCommand ) =
                    rememberAuthAndMaybeChangeTabs childMsg model
            in
                let
                    ( newChildModel, newChildCommand ) =
                        Tabs.Logon.update childMsg ourModel.tabLogon
                in
                    { ourModel | tabLogon = newChildModel } ! [ (Cmd.map LogonMsg newChildCommand), ourCommand ]

        RegisterMsg childMsg ->
            let
                ( newChildModel, newChildCommand ) =
                    Tabs.Register.update childMsg model.tabRegister
            in
                ( { model | tabRegister = newChildModel }, Cmd.map RegisterMsg newChildCommand )

        LogoutMsg ->
            let
                ( newChildModel, newChildCommand ) =
                    Tabs.Logon.update Tabs.Logon.LoggedOut Tabs.Logon.model
            in
                { model | username = Nothing, authToken = Nothing, tabLogon = newChildModel } ! [ Utils.msg2cmd (SelectTab 2) ]

        Mdl msg' ->
            Material.update msg' model

        TablesMsg childMsg ->
            let
                ( newChildModel, newChildCommand ) =
                    Tabs.Tables.update childMsg model.tabTables
            in
                ( { model | tabTables = newChildModel }, Cmd.map TablesMsg newChildCommand )

        PuppiesMsg childMsg ->
            lift .tabPuppies (\m childModel -> { m | tabPuppies = childModel }) PuppiesMsg Tabs.Puppies.update childMsg model

        MonitoringMsg childMsg ->
            let
                ( newChildModel, newChildCommand ) =
                    Tabs.Monitoring.update childMsg model.tabMonitoring
            in
                ( { model | tabMonitoring = newChildModel }, Cmd.map MonitoringMsg newChildCommand )


rememberAuthAndMaybeChangeTabs : Tabs.Logon.Msg -> Model -> ( Model, Cmd Msg )
rememberAuthAndMaybeChangeTabs logonMsg model =
    case logonMsg of
        Tabs.Logon.PostSucceed response ->
            let
                ourCommand =
                    if model.selectedTab == model.desiredTab then
                        Cmd.none
                    else
                        Utils.msg2cmd (SelectTab model.desiredTab)
            in
                ( { model | username = Just response.username, authToken = Just response.token }, ourCommand )

        _ ->
            ( model, Cmd.none )



-- Separate public and private messages?
-- Security / cookies as a generic thing
-- TAB SETUP


type alias ViewFunc =
    Model -> Html Msg


type alias TabInfo =
    { tabName : String
    , tabUrl : String
    , onlyForAuthenticated: Bool
    }


type alias Tab =
    { info : TabInfo
    , tabViewMap : ViewFunc
    }


tabList : List Tab
tabList =
    [ { info = logonTabInfo, tabViewMap = logonTabViewMap }
    , { info = registerTabInfo, tabViewMap = registerTabViewMap }
    , { info = { tabName = "Tables", tabUrl = "tables", onlyForAuthenticated = False}, tabViewMap = tableTabViewMap }
    , { info = { tabName = "Puppies", tabUrl = "puppies", onlyForAuthenticated = False}, tabViewMap = .tabPuppies >> Tabs.Puppies.view >> App.map PuppiesMsg }
    , { info = { tabName = "Monitoring", tabUrl = "monitoring" , onlyForAuthenticated = False}, tabViewMap = .monitoringTabViewMap }
    ]

logonTabInfo : TabInfo
logonTabInfo =
    { tabName = "Logon", tabUrl = "logon", onlyForAuthenticated = True }


logonTabViewMap : Model -> Html Msg
logonTabViewMap model =
    let
        desiredTabInfo =
            Array.get model.desiredTab model.tabInfoArray |> Maybe.withDefault logonTabInfo
    in
        let
            viewWithInjectedArgs =
                Tabs.Logon.view (model.selectedTab /= model.desiredTab) desiredTabInfo.tabName
        in
            .tabLogon model |> viewWithInjectedArgs |> App.map LogonMsg

registerTabInfo : TabInfo
registerTabInfo =
   { tabName = "Register", tabUrl = "register", onlyForAuthenticated = True }


registerTabViewMap : Model -> Html Msg
registerTabViewMap model =
    let
        desiredTabInfo =
            Array.get model.desiredTab model.tabInfoArray |> Maybe.withDefault registerTabInfo
    in
        let
            viewWithInjectedArgs =
                Tabs.Register.view (model.selectedTab /= model.desiredTab) desiredTabInfo.tabName
        in
            .tabRegister model |> viewWithInjectedArgs |> App.map RegisterMsg

tableTabViewMap : Model -> Html Msg
tableTabViewMap model =
    Tabs.Tables.view model.tabTables |> App.map TablesMsg


monitoringTabViewMap : Model -> Html Msg
monitoringTabViewMap model =
    Tabs.Monitoring.view model.tabMonitoring |> App.map MonitoringMsg



-- tabs helpers


tabInfos : List TabInfo
tabInfos =
    List.map .info tabList


tabInfoArray : Array TabInfo
tabInfoArray =
    Array.fromList tabInfos


tabTitlesAll : List String
tabTitlesAll =
    let 
        forAll x = x.onlyForAuthenticated == False
        filtered = List.filter forAll tabInfos
    in 
        List.map .tabName filtered

tabTitlesForAuthenticated : List String
tabTitlesForAuthenticated =
    let 
        filtered = List.filter .onlyForAuthenticated tabInfos
    in 
        List.map .tabName filtered

tabTitlesHTML : Model -> List (Html a)
tabTitlesHTML model =
    if isAuthenticated model then
        List.map text tabTitlesAll
    else
        List.map text tabTitlesForAuthenticated

infoForTab : Int -> TabInfo
infoForTab tab =
    Array.get tab tabInfoArray |> Maybe.withDefault logonTabInfo


tabUrls : Array String
tabUrls =
    List.map .tabUrl tabInfos |> Array.fromList

tabViews : Array (ViewFunc)
tabViews =
    List.map .tabViewMap tabList |> Array.fromList


tabName : Int -> Array TabInfo -> String
tabName index array =
    Array.get index array |> Maybe.withDefault logonTabInfo |> .tabName


urlTabs : Dict String Int
urlTabs =
    List.indexedMap (\idx tabInfo -> ( .tabUrl tabInfo, idx )) tabInfos |> Dict.fromList



-- VIEW


view : Model -> Html Msg
view model =
    let
        currentTab =
            (Array.get model.selectedTab tabViews |> Maybe.withDefault e404) model
        tabsToShow = tabTitlesHTML model
    in
        Material.Scheme.topWithScheme Color.Teal Color.Red <|
            Layout.render Mdl
                model.mdl
                [ Layout.selectedTab model.selectedTab
                , Layout.fixedHeader
                , Layout.onSelectTab SelectTab
                ]
                { header = header model
                , drawer = []
                , tabs = ( tabsToShow, [ Color.background (Color.color Color.Teal Color.S400) ] )
                , main = [ currentTab ]
                }


header : Model -> List (Html Msg)
header model =
    [ Layout.row []
        [ Layout.title [] [ text "Elm MDL/SPA Exploration" ]
        , Layout.spacer
        , div []
            [ text (getLoggedMsg model)
            , Html.br [] []
            , addLogoutButtonIfLogged model
            ]
        ]
    ]

isAuthenticated: Model -> Bool
isAuthenticated model =
    case model.authToken of 
        Just token -> True
        Nothing -> False


addLogoutButtonIfLogged : Model -> Html Msg
addLogoutButtonIfLogged model =
    if isAuthenticated model then
        Button.render Mdl
        [ 0 ]
        model.mdl
        [ Button.onClick LogoutMsg
        ]
        [ text "-> Logout" ]
    else
        div [] []

getLoggedMsg : Model -> String
getLoggedMsg model =
    case model.username of
        Just name -> 
            "Logged in as: " ++ (toString model.username)
        Nothing ->
            ""

e404 : ViewFunc
e404 _ =
    div []
        [ Options.styled Html.h1
            [ Options.cs "mdl-typography--display-4"
            , Typography.center
            ]
            [ text "404" ]
        ]



-- Routing


urlOf : Model -> String
urlOf model =
    "#" ++ (Array.get model.selectedTab tabUrls |> Maybe.withDefault "")


delta2url : Model -> Model -> Maybe Routing.UrlChange
delta2url model1 model2 =
    if model1.selectedTab /= model2.selectedTab then
        { entry = Routing.NewEntry
        , url = urlOf model2
        }
            |> Just
    else
        Nothing


location2messages : Navigation.Location -> List Msg
location2messages location =
    [ case String.dropLeft 1 location.hash of
        "" ->
            SelectTab 0

        x ->
            Dict.get x urlTabs
                |> Maybe.withDefault -1
                |> SelectTab
    ]



-- Main


main : Program Never
main =
    Routing.program
        { delta2url = delta2url
        , location2messages = location2messages
        , init =
            ( { model
                | mdl =
                    Layout.setTabsWidth 2124 model.mdl
              }
            , Utils.msg2cmd (MonitoringMsg GetTime)
            )
        , view = view
        , subscriptions = \model -> Sub.none
        , update = update
        }
