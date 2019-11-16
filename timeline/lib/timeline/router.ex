defmodule Timeline.Router do
  use Plug.Router

  plug :match
  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug :dispatch

  post "/" do
    params = conn.body_params["data"]

    IO.inspect(params)

    send_resp(conn, 200, "Ok")
  end
end
