import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :demosham, DemoshamWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "eYPY0cytfftAMUiqPHEoYLL/pdYIfBbXuLP2q41zMN7vN5OZoDgCZyvEo4Q+ydaN",
  server: false

# In test we don't send emails
config :demosham, Demosham.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
