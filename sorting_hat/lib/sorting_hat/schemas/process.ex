defmodule SortingHat.Schema.Process do
  use Ecto.Schema

  schema "processes" do
    field :node
    field :state, :jsonb
    field :process_until, :integer
  end
end
