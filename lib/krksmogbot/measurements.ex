defmodule Krksmogbot.Measurements do
  require Logger

  def get_measurements(latitude, longitude) do
    with {:ok, %{"current" => data, "history" => [previous_data | _]}} <-
           Airlyapi.get_map_point_measurements(latitude, longitude) do
      measurements_to_text(data, previous_data)
    else
      {_, error} -> Logger.error("Error accessing Airly: #{inspect(error)}")
    end
  end

  defp measurements_to_text(data, _) when map_size(data) == 0 do
    "Sorry, there's no data for your location"
  end

  defp measurements_to_text(
         %{"indexes" => [data], "standards" => [pm25, pm10], "values" => values},
         %{"indexes" => [yesterday_data]}
       ) do
    [
      to_message(:caqi, data["value"], data["description"], data["advice"]),
      to_message(
        :yesterday,
        round(data["value"] - yesterday_data["value"]) |> div(10)
      ),
      to_message(:pm25, pm25),
      to_message(:pm10, pm10),
      to_message(
        :temp,
        values
        |> Enum.find(fn
          %{"name" => "TEMPERATURE"} -> true
          _ -> false
        end)
      )
    ]
    |> Enum.join("\n")
  end

  defp to_message(:caqi, caqi, description, advice),
    do: "*CAQI*: #{if caqi, do: round(caqi)} *#{description}*\n#{advice}"

  defp to_message(:pm25, %{"pollutant" => "PM25", "percent" => percent}),
    do: "*PM25*: #{percent}%"

  defp to_message(:pm10, %{"pollutant" => "PM10", "percent" => percent}),
    do: "*PM10*: #{percent}%"

  defp to_message(:temp, nil), do: "*Temperature*:"
  defp to_message(:temp, %{"value" => temp}), do: "*Temperature*: #{round(temp)}°C"
  defp to_message(:yesterday, diff) when diff < -5, do: "*Better than yesterday* 💚💚💚💚💚💚"
  defp to_message(:yesterday, -5), do: "*Better than yesterday* 💚💚💚💚💚"
  defp to_message(:yesterday, -4), do: "*Better than yesterday* 💚💚💚💚"
  defp to_message(:yesterday, -3), do: "*Better than yesterday* 💚💚💚"
  defp to_message(:yesterday, -2), do: "*Better than yesterday* 💚💚"
  defp to_message(:yesterday, -1), do: "*Better than yesterday* 💚"
  defp to_message(:yesterday, 0), do: "*Same as yesterday*"
  defp to_message(:yesterday, 1), do: "*Worse than yesterday* ❗️"
  defp to_message(:yesterday, 2), do: "*Worse than yesterday* ❗️❗️"
  defp to_message(:yesterday, 3), do: "*Worse than yesterday* ❗️❗️❗️"
  defp to_message(:yesterday, 4), do: "*Worse than yesterday* ❗️❗️❗️❗️"
  defp to_message(:yesterday, 5), do: "*Worse than yesterday* ❗️❗️❗️❗️❗️"
  defp to_message(:yesterday, diff) when diff > 5, do: "*Worse than yesterday* ❗️❗️❗️❗️❗️❗️"
end
