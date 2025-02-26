defmodule MyApp.Facility.Command.MarkSelectorSectionAsNonexistent do
  @moduledoc false

  use MyApp.Support.InputSchema

  @type t :: %__MODULE__{
          selector_section_id: String.t()
        }

  embedded_schema do
    field(:selector_section_id, :string)
  end

  @permitted_fields [
    :selector_section_id
  ]

  def changeset(input_struct, params) do
    input_struct
    |> Ecto.Changeset.cast(params, @permitted_fields)
    |> Ecto.Changeset.validate_required(@permitted_fields)
  end
end
