defmodule CampusTalksWeb.Router do
  use CampusTalksWeb, :router

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

  scope "/", CampusTalksWeb do
    pipe_through :browser

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: CampusTalksWeb.Schema,
      interface: :advanced

    get "/", PageController, :index
  end

  scope "/api", CampusTalksWeb do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: CampusTalksWeb.Schema
  end
end
