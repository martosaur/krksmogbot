defmodule Krksmogbot do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
        worker(Krksmogbot.Poller, []),
        Plug.Adapters.Cowboy.child_spec(:http, Krksmogbot.Healthcheck, [], port: 4000)
    ]
    opts = [strategy: :one_for_one, name: Krksmogbot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
