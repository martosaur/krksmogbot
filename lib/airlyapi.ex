defmodule Airlyapi do
    use HTTPoison.Base
    require Logger
    alias API.Helper

    defp api_token, do: Helper.config_or_env(:airly_token)
    
    defp process_url(url) do
        "https://airapi.airly.eu" <> url
    end

    defp process_request_headers(headers) do
        headers
        |> Enum.into([apikey: api_token])
    end

    defp process_response_body(body) do
        Poison.decode!(body)
    end

    def get_map_point_measurements(latitude, longitude) do
        case get("/v1/mapPoint/measurements", [], [params: [latitude: latitude, longitude: longitude]]) do
            {:ok, response} -> {:ok, response.body}
            {:error, response} -> {:error, response.reason}
        end
    end
end