defmodule Acca.Client.Timeline do
  def info(data) do
    request(Map.put(data, :severity, "INFO"))
  end

  defp request(data) do
    payload = Jason.encode!(%{"data" => Map.put(data, :node, identifier)})

    HTTPoison.post("http://localhost:4001", payload, headers)
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
end
