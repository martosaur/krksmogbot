defmodule Airlyapi do
  use HTTPoison.Base
  require Logger

  defp api_token, do: Application.get_env(:krksmogbot, :airly_token)

  def process_url(url) do
    "https://airapi.airly.eu" <> url
  end

  def process_request_headers(headers) do
    headers
    |> Keyword.put(:apikey, api_token())
  end

  def process_response_body(body) do
    Jason.decode!(body)
  end

  def get_map_point_measurements(latitude, longitude) do
    case get("/v2/measurements/point", [], params: [lat: latitude, lng: longitude]) do
      {:ok, response} -> {:ok, response.body}
      {:error, response} -> {:error, response.reason}
    end
  end
end
