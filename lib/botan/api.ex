defmodule Botan.API do
  use HTTPoison.Base
  require Logger
  alias API.Helper

  defp api_token, do: Helper.config_or_env(:botan_token)
  
  defp process_url(url) do
    "https://api.botan.io" <> url
  end
  
  defp process_request_options(options) do
    put_in(options[:params], options[:params] ++ [token: api_token])
  end
  
  defp process_request_body(body) do
    Poison.encode!(body)
  end
  
  defp process_response_body(body) do
    case Poison.decode(body) do
      {:ok, body} -> body
      {:error, error} -> Logger.error(inspect(error))
                          body
    end
  end
  
  def track(uid, command, message) do
    case post("/track", message, [], [params: [uid: uid, name: command]]) do
      {:ok, response} -> {:ok, response}
      {:error, response} -> Logger.error(inspect(response))
                              {:error, response}
    end
  end
  
  def shorten(url, uid) do
    case get!("/s", [], params: [user_ids: uid, url: url]) do
      %{status_code: 200} = r -> {:ok, r}
      r -> {:error, r}
    end
  end
end