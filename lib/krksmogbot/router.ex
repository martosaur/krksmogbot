defmodule Krksmogbot.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug(:match)
  plug(:dispatch)

  get("/", to: Krksmogbot.Healthcheck)

  post("/:token/", to: Krksmogbot.Webhook)

  match _ do
    send_resp(conn, 404, "Page not found")
  end

  defp handle_errors(conn, _) do
    send_resp(conn, 500, "Internal server error")
  end
end
