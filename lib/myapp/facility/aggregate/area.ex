defmodule MyApp.Facility.Aggregate.Area do
  @moduledoc false

  defstruct registered: false

  alias MyApp.Facility.Aggregate.Area

  alias MyApp.Facility.Command.RegisterArea

  alias MyApp.Facility.Event.AreaRegistered

  @opaque t :: %__MODULE__{
            registered: boolean()
          }

  @doc """
  Execute a domain command.
  """
  @spec execute(t, RegisterArea.t()) ::
          AreaRegistered.t()
          | {:error, :area_already_registered}

  def execute(%Area{registered: false}, %RegisterArea{} = command) do
    struct(AreaRegistered, Map.take(command, [:area_id]))
  end

  def execute(%Area{}, %RegisterArea{}) do
    {:error, :area_already_registered}
  end

  @doc """
  Apply an event to the state.
  """
  @spec apply(t, AreaRegistered.t()) :: t

  def apply(%Area{} = area, %AreaRegistered{} = _event) do
    %Area{area | registered: true}
  end
end
