defmodule MyApp.Facility do
  @moduledoc """
  The boundary for the Facility system.
  """

  alias MyApp.CQRS
  alias MyApp.Support.InputBuilder

  alias MyApp.Facility.Command.RegisterArea

  def register_area(params \\ %{}, opts \\ [])
      when is_map(params) and is_list(opts) do
    id = UUID.uuid4(:default)
    identity = %{area_id: id}

    params = Map.put(params, :area_id, id)

    case execute(RegisterArea, params) do
      :ok ->
        {:ok, identity}

      result ->
        result
    end
  end

  def execute(command_module, params) do
    with {:ok, command} <- InputBuilder.build(command_module, params) do
      CQRS.dispatch(command)
    end
  end
end
