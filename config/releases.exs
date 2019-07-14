import Config

config :krksmogbot,
  airly_token: System.fetch_env!("AIRLY_TOKEN"),
  use_webhook: System.get_env("USE_WEBHOOK", "false"),
  webhook_token: System.get_env("WEBHOOK_TOKEN", "mytoken"),
  webhook_url: System.get_env("WEBHOOK_URL", "https://localhost/"),
  webhook_max_connections: System.get_env("WEBHOOK_MAX_CONNECTIONS", "40") |> String.to_integer()

config :nadia,
  token: System.fetch_env!("NADIA_BOT_TOKEN")
