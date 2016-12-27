defmodule TeamVacationTool.Router do
  use TeamVacationTool.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug TeamVacationTool.GraphQL.Context
  end

  scope "/", TeamVacationTool do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api" do
    pipe_through :api

    scope "/rest", TeamVacationTool do
      resources "/users", UserController, only: [:create, :index]
      resources "/teams", TeamController
    end

    scope "/graphql" do
      pipe_through :graphql
      forward "/", Absinthe.Plug, schema: TeamVacationTool.GraphQL.Schema
    end
  end

  if Mix.env == :dev do
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: TeamVacationTool.GraphQL.Schema
  end
end
