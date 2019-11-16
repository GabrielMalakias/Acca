defmodule Acca.Worker.DynamicSupervisor do
  use DynamicSupervisor

  def start_link(args) do
    IO.puts "Starting Supervisor"

    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def start_child(state) do
    spec = {Acca.Worker.RecipeGenServer, state}

    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @impl true
  def init(args) do
    DynamicSupervisor.init(strategy: :one_for_one, extra_arguments: [args])
  end
end
