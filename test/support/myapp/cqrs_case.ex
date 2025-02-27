defmodule MyApp.CqrsCase do
  @moduledoc false

  # Based on commanded documentation: https://hexdocs.pm/commanded/testing.html#tests-using-the-event-store-and-read-store

  use ExUnit.CaseTemplate

  setup do
    {:ok, _} = Application.ensure_all_started(:myapp)

    on_exit(fn ->
      # Uncomment to prevent `unknown registry: MyApp.EventStore.EventStore.PubSub` error messages
      # :timer.sleep(100)

      :ok = Application.stop(:myapp)

      MyApp.Storage.reset!()
    end)

    :ok
  end
end
