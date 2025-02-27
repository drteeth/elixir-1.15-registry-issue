defmodule MyApp.MyBoundedContext.Supervisor do
  @moduledoc false

  use Supervisor

  alias MyApp.MyBoundedContext.ProcessManager

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def init(_init_arg) do
    children = [
      ProcessManager.MyProcessManager
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
