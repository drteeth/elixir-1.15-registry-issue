defmodule MyApp.Facility.Event.AreaRegistered do
  @moduledoc false

  @derive Jason.Encoder
  @enforce_keys [
    :area_id,
    :name
  ]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          area_id: String.t(),
          name: String.t()
        }
end
