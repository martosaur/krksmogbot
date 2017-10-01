defmodule Airlyapi do
    use HTTPoison.Base
    require Logger

    defp api_token, do: config_or_env(:airly_token)
    
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

    defp config_or_env(key) do
        case Application.fetch_env(:krksmogbot, key) do
          {:ok, {:system, var}} -> System.get_env(var)
          {:ok, {:system, var, default}} ->
            case System.get_env(var) do
              nil -> default
              val -> val
            end
          {:ok, value} -> value
          :error -> nil
        end
    end
end