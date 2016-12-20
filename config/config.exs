# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :team_vacation_tool,
  ecto_repos: [TeamVacationTool.Repo]

# Configures the endpoint
config :team_vacation_tool, TeamVacationTool.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Sjv4jM4zBL61/Eaof+7RaChSQDRJpXMlqIoDJBodsI/qT6m9lc0C7OJunm/Pr992",
  render_errors: [view: TeamVacationTool.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TeamVacationTool.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "TeamVacationTool",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "Sjv4jM4zBL61/Eaof+7RaChSQDRJpXMlqIoDJBodsI/qT6m9lc0C7OJunm/Pr992",
  serializer: TeamVacationTool.GuardianSerializer
