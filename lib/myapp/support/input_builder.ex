defmodule MyApp.Support.InputBuilder do
  @moduledoc false

  @doc """
  Build an input of the given struct with the given parameters.

  Returns `{:ok, input}` if successful or `{:error, {:validation_failure, changeset}}` if not.
  """
  @spec build(atom, map) ::
          {:ok, struct}
          | {:error, {:validation_failure, changeset :: Ecto.Changeset.t()}}
  def build(input_module, params \\ %{}) do
    struct(input_module)
    |> input_module.changeset(params)
    |> do_build()
  end

  defp do_build(%Ecto.Changeset{valid?: true} = changeset) do
    {:ok, Ecto.Changeset.apply_changes(changeset)}
  end

  defp do_build(%Ecto.Changeset{} = changeset) do
    {:error, {:validation_failure, changeset}}
  end
end
