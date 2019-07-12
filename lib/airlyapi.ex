defmodule Airlyapi do
  use HTTPoison.Base
  require Logger

  defp api_token, do: Application.get_env(:krksmogbot, :airly_token)

  defp process_url(url) do
    "https://airapi.airly.eu" <> url
  end

  defp process_request_headers(headers) do
    headers
    |> Keyword.put(:apikey, api_token())
  end

  defp process_response_body(body) do
    Poison.decode!(body)
  end

  def get_map_point_measurements(latitude, longitude) do
    case get("/v2/measurements/point", [], params: [lat: latitude, lng: longitude]) do
      {:ok, response} -> {:ok, response.body}
      {:error, response} -> {:error, response.reason}
    end
  end
end
