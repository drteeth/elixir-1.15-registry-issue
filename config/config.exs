import Config

config :myapp,
  namespace: MyApp,
  event_stores: [MyApp.EventStore],
  ecto_repos: []

# CQRS event store database
config :myapp, MyApp.EventStore,
  column_data_type: "jsonb",
  serializer: Commanded.Serialization.JsonSerializer,
  types: EventStore.PostgresTypes,
  url: "ecto://postgres@localhost:5432/postgres",
  pool_size: 10

config :logger,
  level: :warning

# Logger
config :logger, :console,
  format: "$time [$level] $message\n$metadata\n\n",
  metadata: :all
