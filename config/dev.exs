import Config

# CQRS event store database
config :myapp, MyApp.EventStore,
  url: "ecto://default_eventstore@localhost:5001/default_eventstore",
  pool_size: 10

# Logger
config :logger,
  utc_log: false
