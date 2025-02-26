defmodule MyApp.Facility.Command.RegisterArea do
  @moduledoc false

  use MyApp.Support.InputSchema

  @type t :: %__MODULE__{
          area_id: String.t(),
          name: String.t()
        }

  embedded_schema do
    field(:area_id, :string)
    field(:name, :string)
  end

  @permitted_fields [
    :area_id,
    :name
  ]

  def changeset(input_struct, params) do
    input_struct
    |> Ecto.Changeset.cast(params, @permitted_fields)
    |> Ecto.Changeset.validate_required(@permitted_fields)
  end
end
