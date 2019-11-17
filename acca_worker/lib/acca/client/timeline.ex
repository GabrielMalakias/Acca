defmodule Acca.Client.Timeline do
  def info(data) do
    request(Map.put(data, :severity, "INFO"))
  end

  defp request(data) do
    payload = Jason.encode!(%{"data" => Map.put(data, :node, identifier)})

    host
    |> build_uri
    |> HTTPoison.post(payload, headers)
  end

  defp build_uri({:ok, host}) do
    "http://#{host}:4001"
  end

  defp build_uri(_args) do
    "http://localhost:4001"
  end

  defp headers do
    [{"Content-Type", "application/json"}]
  end

  defp request(_error, data) do
    IO.puts("Failed to request data")
  end

  defp identifier do
    System.fetch_env!("NODE")
  end

  defp host do
    System.fetch_env("LOGGER_API")
  end
end
