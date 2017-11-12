defmodule Botan do
  require Logger
  
  def track(message) do
    case message do
      %{message: %{text: nil, from: %{username: uid}}} -> Botan.API.track(uid, "/location", message)
      %{message: %{text: text, from: %{username: uid}}} -> Botan.API.track(uid, text, message)
      r -> Logger.error("Could not report following message: #{inspect(message)}")
    end
  end
end