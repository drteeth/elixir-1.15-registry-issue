defmodule MyApp.Facility.Event.SelectorMarkedAsNonexistent do
  @moduledoc false

  @derive Jason.Encoder
  @enforce_keys [
    :selector_id
  ]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          selector_id: String.t()
        }
end
