defmodule MyApp.Support.InputSchema do
  @moduledoc false

  @doc """
  Callback to build a changeset with the given parameters.
  """
  @callback changeset(
              input_struct :: Ecto.Schema.t(),
              params :: %{optional(atom()) => any()}
            ) :: Ecto.Changeset.t()

  defmacro __using__(_opts) do
    quote do
      use Ecto.Schema
      @primary_key false

      @behaviour MyApp.Support.InputSchema
    end
  end
end
