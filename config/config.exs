# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :campus_talks,
  ecto_repos: [CampusTalks.Repo]

# Configures the endpoint
config :campus_talks, CampusTalksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MKrKUEtd3qPelx8nILEUOHwsjm2o05br43yAczC7f/xiE67PGFQ7MVV5pKHK9iv2",
  render_errors: [view: CampusTalksWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CampusTalks.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
