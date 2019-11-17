defmodule Acca.Worker.Recipe do
  def init_args(id) do
    %{name: :pizza, id: id, cooked_for: 0}
  end
end
