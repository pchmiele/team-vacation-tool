module Tabs.Monitoring exposing (..)

import Html.App as App
import Html exposing (..)
import Material
import Material.Card as Card
import Material.Color as Color
import Material.Options as Options exposing (cs, css)


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
    }


type alias Model =
    { mdl : Material.Model
    }


type Msg
    = Placeholder


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


white : Options.Property c m
white =
    Color.text Color.white


view : Model -> Html Msg
view model =
    div []
        [ Options.div
            [ Options.center ]
            [ Card.view
                [ css "width" "128px"
                , Color.background (Color.color Color.Green Color.S500)
                ]
                [ Card.title [] [ Card.head [ white ] [ text "Nodes" ] ]
                , Card.text [ white ] []
                , Card.media []
                    [ Card.view
                        [ css "width" "128px"
                        , Color.background (Color.color Color.Red Color.S500)
                        ]
                        [ Card.title [] [ Card.head [ white ] [ text "node1" ] ]
                        , Card.text [ white ] []
                        ]
                    , Card.view
                        [ css "width" "128px"
                        , Color.background (Color.color Color.Blue Color.S500)
                        ]
                        [ Card.title [] [ Card.head [ white ] [ text "node2" ] ]
                        , Card.text [ white ] []
                        ]
                    ]
                ]
            ]
        ]
