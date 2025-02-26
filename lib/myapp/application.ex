defmodule MyApp.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      MyApp.CQRS,
      MyApp.Facility.Supervisor
    ]

    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
