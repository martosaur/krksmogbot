import Config

config :krksmogbot,
  airly_token: System.fetch_env!("AIRLY_TOKEN")

config :nadia,
  token: System.fetch_env!("NADIA_BOT_TOKEN")
