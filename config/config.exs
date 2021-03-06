# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tb,
  namespace: TB,
  ecto_repos: [TB.Repo]

# Configures the endpoint
config :tb, TBWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cJtR2zvbzNTWrVHF18dbzMxnoGhRfr7o0RF+U+ZAdwB3CEiXzUQOUrkHHuhv1zZM",
  render_errors: [view: TBWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TB.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders, "json-api": Poison

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}


config :tb, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: TBWeb.Router,     # phoenix routes will be converted to swagger paths
      endpoint: TBWeb.Endpoint  # (optional) endpoint config used to set host, port and https schemes.
    ]
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
