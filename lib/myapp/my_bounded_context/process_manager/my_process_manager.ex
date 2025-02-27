defmodule MyApp.MyBoundedContext.ProcessManager.MyProcessManager do
  @moduledoc false

  use Commanded.ProcessManagers.ProcessManager,
    application: MyApp.CQRS,
    name: "MyProcessManager"

end
