defmodule Acca.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    HTTPoison.start

    children = [
      Acca.Worker.DynamicSupervisor
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
