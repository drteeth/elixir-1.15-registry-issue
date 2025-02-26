defmodule MyApp.EventStore do
  @moduledoc false

  use EventStore,
    otp_app: :myapp
end
