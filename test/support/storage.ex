defmodule MyApp.Storage do
  @moduledoc false

  alias EventStore.Storage.Initializer

  @doc """
  Clear the event store and read store databases
  """
  def reset! do
    reset_eventstore()
  end

  defp reset_eventstore do
    config = MyApp.EventStore.config()

    {:ok, conn} = Postgrex.start_link(config)

    Initializer.reset!(conn, config)
  end
end
