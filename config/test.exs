import Config

config :myapp, MyApp.EventStore,
  url:
    System.get_env(
      "MYAPP_EVENTSTORE",
      "ecto://default_eventstore@localhost:5002/default_eventstore"
    ),
  pool_size: 1

config :logger,
  level: :warning
