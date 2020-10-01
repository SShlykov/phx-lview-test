# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :w_dcr, WDcrWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "L0o3IKK9Pwokq5L0GNH7yAOD255H1jO3orkT91ChiafLE92aigQjPu8/Q/43WD5/",
  render_errors: [view: WDcrWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: WDcr.PubSub,
  live_view: [signing_salt: "/Hk61Wua"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
