module Tabs.Monitoring exposing (Model, model, view, update, Msg(..))

import Html.App as App
import Html exposing (..)
import Material
import Date exposing (Date, Month(..))
import Html.Attributes exposing (class)
import Date.Extra as Date exposing (Interval(Year, Month, Day))
import DateSelectorDropdown
import Task
import Time exposing (Time)
import Material.Options as Options exposing (nop)


main : Program Never
main =
    App.program
        { init = ( model, Cmd.none )
        , view = view
        , subscriptions = always Sub.none
        , update = update
        }


model : Model
model =
    { mdl = Material.model
    , today = today
    , from = today
    , to = today
    , openDateField = Nothing
    }


today : Date
today =
    Date.fromCalendarDate 2016 Sep 15


type alias Model =
    { mdl : Material.Model
    , today : Date
    , from : Date
    , to : Date
    , openDateField : Maybe DateField
    }


type Msg
    = Select DateField Date
    | OpenDropdown DateField
    | CloseDropdown
    | GetTime
    | GetTimeSuccess Time
    | GetTimeFailure String


type DateField
    = From
    | To


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Select dateField date ->
            case dateField of
                From ->
                    let
                        newFrom =
                            date

                        newTo =
                            calculateNewTo model.to date
                    in
                        { model | from = newFrom, to = newTo } ! []

                To ->
                    { model | to = date } ! []

        OpenDropdown dateField ->
            { model | openDateField = Just dateField } ! []

        CloseDropdown ->
            { model | openDateField = Nothing } ! []

        GetTime ->
            model ! [ getCurrentTime ]

        GetTimeSuccess time ->
            let
                currentDate =
                    (Date.fromTime time)
            in
                { model | today = currentDate, to = (Date.add Day 1 currentDate), from = currentDate } ! []

        GetTimeFailure msg ->
            model ! []


view : Model -> Html Msg
view { mdl, today, from, to, openDateField } =
    Options.div
        [ Options.center ]
        [ div
            []
            [ Html.node "style"
                []
                [ text <| "@import url(../css/date-selector.css);"
                ]
            , div
                [ class "columns" ]
                [ div []
                    [ label [] [ text "From" ]
                    , viewDateSelector From
                        openDateField
                        today
                        (Date.add Year 1 today)
                        (Just from)
                    ]
                , div []
                    [ label [] [ text "To" ]
                    , viewDateSelector To
                        openDateField
                        (Date.add Day 1 from)
                        (Date.add Year 1 from)
                        (Just to)
                    ]
                ]
            ]
        ]


viewDateSelector : DateField -> Maybe DateField -> Date -> Date -> Maybe Date -> Html Msg
viewDateSelector dateField openDateField =
    let
        isOpen =
            openDateField |> Maybe.map ((==) dateField) |> Maybe.withDefault False
    in
        DateSelectorDropdown.view
            (if isOpen then
                CloseDropdown
             else
                OpenDropdown dateField
            )
            (Select dateField)
            isOpen


getCurrentTime : Cmd Msg
getCurrentTime =
    Task.perform GetTimeFailure GetTimeSuccess Time.now


calculateNewTo : Date -> Date -> Date
calculateNewTo oldTo newFrom =
    if Date.toTime newFrom > Date.toTime oldTo then
        (Date.add Day 1 newFrom)
    else
        oldTo
