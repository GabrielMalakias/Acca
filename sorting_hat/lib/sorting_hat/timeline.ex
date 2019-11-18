defmodule SortingHat.Timeline do
  def info(data) do
    request(:put, '/', Map.put(data, :severity, "INFO"))
  end

  def load do
    request(:get, '/load', %{})
  end

  defp request(method, path, data) do
    payload = Jason.encode!(%{"data" => Map.put(data, :node, identifier)})

    uri = build_uri(host, path)

    apply(HTTPoison, post, uri, payload, headers)
  end

  defp build_uri({:ok, host}, path) do
    "http://#{host}:4001/#{path}"
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
