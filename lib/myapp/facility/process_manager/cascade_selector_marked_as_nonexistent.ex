defmodule MyApp.Facility.ProcessManager.CascadeSelectorMarkedAsNonexistent do
  @moduledoc false

  use Commanded.ProcessManagers.ProcessManager,
    application: MyApp.CQRS,
    name: "CascadeSelectorMarkedAsNonexistent"

  @derive Jason.Encoder
  defstruct selector_section_ids: []

  alias MyApp.Facility.ProcessManager.CascadeSelectorMarkedAsNonexistent

  alias MyApp.Facility.Event.{
    SelectorMarkedAsNonexistent,
    SelectorSectionRegistered
  }

  alias MyApp.Facility.Command.MarkSelectorSectionAsNonexistent

  @typep selector_section_id :: String.t()

  @opaque t :: %__MODULE__{
            selector_section_ids: [selector_section_id]
          }

  # Process routing

  def interested?(%SelectorMarkedAsNonexistent{selector_id: selector_id}) do
    {:continue, selector_id}
  end

  def interested?(%SelectorSectionRegistered{selector_id: selector_id}) do
    {:start, selector_id}
  end

  # Command dispatch

  def handle(
        %CascadeSelectorMarkedAsNonexistent{} = pm,
        %SelectorMarkedAsNonexistent{} = _event
      ) do
    Enum.map(
      pm.selector_section_ids,
      fn selector_section_id ->
        %MarkSelectorSectionAsNonexistent{selector_section_id: selector_section_id}
      end
    )
  end

  # State mutators

  def apply(
        %CascadeSelectorMarkedAsNonexistent{} = pm,
        %SelectorSectionRegistered{} = event
      ) do
    %CascadeSelectorMarkedAsNonexistent{
      pm
      | selector_section_ids: [event.selector_section_id | pm.selector_section_ids]
    }
  end
end
