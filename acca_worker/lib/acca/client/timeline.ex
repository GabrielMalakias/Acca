defmodule Acca.Client.Timeline do
  def log(data) do
    connect()
    |> request(data)
  end

  defp request({:ok, conn}, data) do
    payload = Jason.encode!(%{"data" => Map.put(data, :node, identifier)})

    Mint.HTTP.request(conn, "POST", "/", [{"Content-Type", "application/json"}], payload)
  end

  defp request(_error, data) do
    IO.puts("Failed to request data")
  end

  defp identifier do
    System.fetch_env!("NODE")
  end

  defp connect do
    Mint.HTTP.connect(:http, "localhost", 4001)
  end
end
