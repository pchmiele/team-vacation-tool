module Routing exposing (..)

import Navigation
import UrlParser exposing (..)
import UrlParser


type Route
    = HomeIndexRoute
    | SignInRoute
    | SignUpRoute
    | NotFoundRoute


toPath : Route -> String
toPath route =
    case route of
        HomeIndexRoute ->
            "/"

        SignInRoute ->
            "/sign-in"

        SignUpRoute ->
            "/sign-up"

        NotFoundRoute ->
            "/not-found"


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeIndexRoute (s "")
        , map SignInRoute (s "sign-in")
        , map SignUpRoute (s "sign-up")
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
    case parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
