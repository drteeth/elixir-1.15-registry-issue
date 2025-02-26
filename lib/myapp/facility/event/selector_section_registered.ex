defmodule MyApp.Facility.Event.SelectorSectionRegistered do
  @moduledoc false

  @derive Jason.Encoder
  @enforce_keys [
    :selector_section_id,
    :selector_id,
    :name
  ]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          selector_section_id: String.t(),
          selector_id: String.t(),
          name: String.t()
        }
end
