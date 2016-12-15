module Routing exposing (..)

import Navigation
import UrlParser exposing (..)
import UrlParser


type Route
    = HomeIndexRoute
    | LoginNewRoute
    | RegistrationNewRoute
    | NotFoundRoute


toPath : Route -> String
toPath route =
    case route of
        HomeIndexRoute ->
            "/"

        LoginNewRoute ->
            "/sign-in"

        RegistrationNewRoute ->
            "/sign-up"

        NotFoundRoute ->
            "/not-found"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeIndexRoute (s "")
        , map LoginNewRoute (s "sign-in")
        , map RegistrationNewRoute (s "sign-up")
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
    case parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
