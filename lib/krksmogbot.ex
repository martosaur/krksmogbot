defmodule Krksmogbot do
  use Application

  def start(_type, _args) do
    router = Plug.Cowboy.child_spec(scheme: :http, plug: Krksmogbot.Router, options: [port: 4000])

    children =
      case Krksmogbot.Webhook.setup_webhook() do
        :ok ->
          [router]

        {:error, _} ->
          [Krksmogbot.Poller, router]
      end

    opts = [strategy: :one_for_one, name: Krksmogbot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
