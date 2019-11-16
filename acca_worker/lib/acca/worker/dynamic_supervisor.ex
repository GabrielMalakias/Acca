defmodule Acca.Worker.DynamicSupervisor do
  use DynamicSupervisor

  def start_link(args) do
    IO.puts "Starting Supervisor"

    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def start_child(state) do
    spec = Acca.Worker.RecipeGenServer.child_spec(state)

    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
