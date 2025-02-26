defmodule MyApp.Facility.Router do
  @moduledoc false

  use Commanded.Commands.Router

  alias MyApp.Facility.{
    Aggregate,
    Command
  }

  middleware(Commanded.Middleware.Logger)

  identify(Aggregate.Area, by: :area_id, prefix: "area-")

  dispatch(
    [
      Command.RegisterArea
    ],
    to: Aggregate.Area
  )
end
