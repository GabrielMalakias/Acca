defmodule Acca.Worker.RecipeGenServer do
  use GenServer, restart: :transient

  alias Acca.Client.Timeline, as: Logger

  @impl true
  def init(state) do
    schedule_work()

    {:ok, state}
  end

  def start_link(state) do
    retrieve_info(state)

    %{name: name, id: id} = state

    identifier = String.to_atom("#{name}_#{id}")

    result = GenServer.start_link(__MODULE__, state, name: { :global, identifier})

    result
  end

  @impl true
  def handle_info({:tcp}, state) do
    {:noreply, state}
  end

  @impl true
  def handle_info(:cook, state) do
    %{cooked_for: seconds, name: name, id: id} = state

    Logger.info %{msg: "Cooking #{name} #{id} for #{seconds} seconds"}

    schedule_work()

    {:noreply, Map.put(state, :cooked_for, seconds + 1)}
  end

  @impl true
  def handle_cast(:finished, state) do
    %{name: name} = state

    Logger.info %{msg: "Finished #{name}"}

    DynamicSupervisor.terminate_child(Acca.Worker.DynamicSupervisor, self())

    {:no_reply, state}
  end

  def retrieve_info(%{name: name, id: id}) do
    Logger.info %{msg: "Retrieving Info from api/#{name}/#{id}"}
  end

  def schedule_work do
    Process.send_after(self(), :cook, 1000)
  end
end
