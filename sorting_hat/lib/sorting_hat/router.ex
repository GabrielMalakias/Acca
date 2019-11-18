defmodule SortingHat.Router do
  use GenServer, restart: :permanent

  def start_link(_args) do
    GenServer.start_link(__MODULE__, 0)
  end

  @impl true
  def init(_state) do
    schedule_work()

    {:ok, 0}
  end

  @impl true
  def handle_info(:load, state) do
  end

  defp schedule_work do
    Process.send_after(self(), :load, 10 * 1000)
  end
end

