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
    plug TeamVacationTool.Context
    # plug Absinthe.Plug, 
    #   schema: TeamVacationTool.Schema,
    #   path: "/graphql"

    # if Mix.env == :dev do
    #   plug Absinthe.Plug.GraphiQL, 
    #     schema: TeamVacationTool.Schema,
    #     path: "/graphiql"
    # end
  end

  scope "/", TeamVacationTool do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", TeamVacationTool do
    pipe_through :api

    resources "/users", UserController, only: [:create, :index]
    resources "/sessions", SessionController, only: [:create] 
    resources "/teams", TeamController
  end

  get "/graphiql", Absinthe.Plug.GraphiQL, schema: TeamVacationTool.Schema
  post "/graphiql", Absinthe.Plug.GraphiQL, schema: TeamVacationTool.Schema
  forward "/graphql", Absinthe.Plug, schema: TeamVacationTool.Schema

end
