defmodule MyApp.CQRS do
  @moduledoc false

  use Commanded.Application,
    otp_app: :myapp,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: MyApp.EventStore
    ]

  router(MyApp.Facility.Router)
end
