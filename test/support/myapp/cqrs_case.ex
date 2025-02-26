defmodule MyApp.CqrsCase do
  @moduledoc false

  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  setup do
    {:ok, _} = Application.ensure_all_started(:myapp)

    on_exit(fn ->
      :ok = Application.stop(:myapp)

      MyApp.Storage.reset!()
    end)

    :ok
  end
end
