defmodule Acca.Worker.Producer do
  use GenServer, restart: :permanent

  alias Acca.Worker.DynamicSupervisor, as: DSupervisor
  alias Acca.Client.Timeline, as: Logger

  def start_link(_args) do
    GenServer.start_link(__MODULE__, 0)
  end

  @impl true
  def init(_state) do
    schedule_work()

    {:ok, 0}
  end

  @impl true
  def handle_info(:enqueue_new, state) do
    0..1000000
    |> Enum.random
    |> enqueue_new_recipe
    |> log_new_recipe

    schedule_work()

    {:noreply, state + 1}
  end

  defp enqueue_new_recipe(number) do
    number
    |> Acca.Worker.Recipe.init_args
    |> DSupervisor.start_child

    number
  end

  defp log_new_recipe(number) do
    Logger.info %{msg: "Enqueueing a new recipe #{number}"}
  end

  defp schedule_work do
    Process.send_after(self(), :enqueue_new, 5 * 1000)
  end
end


