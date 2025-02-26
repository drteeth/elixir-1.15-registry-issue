import Config

# CQRS event store database
config :myapp, MyApp.EventStore, pool_size: 10

# Logger
config :logger,
  level: :info,
  utc_log: true

config :logger, :console,
  format: "[$level] $message\n$metadata\n\n",
  metadata: :all
