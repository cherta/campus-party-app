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

  scope "/" do
    pipe_through [:browser]
    get "/", CampusTalksWeb.PageController, :index

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: CampusTalksWeb.Schema,
      interface: :advanced
  end

  scope "/api" do
    pipe_through :api
    forward "/", Absinthe.Plug, schema: CampusTalksWeb.Schema
  end
end
