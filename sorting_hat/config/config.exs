use Mix.Config

config :sorting_hat, ecto_repos: [SortingHat.Repo]

config :sorting_hat, SortingHat.Repo,
 database: "sorting_hat",
 username: "postgres",
 password: "postgres",
 hostname: "db",
 port: "5432"
