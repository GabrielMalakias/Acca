defmodule SortingHat.Repo do
  use Ecto.Repo,
    otp_app: :sorting_hat,
    adapter: Ecto.Adapters.Postgres
end
