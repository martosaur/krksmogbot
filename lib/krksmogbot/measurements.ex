defmodule Krksmogbot.Measurements do
  require Logger
  
  @pm25_norm 25
  @pm10_norm 50
  @pollution_level %{
    0 => ["No current data"],
    1 => ["Wonderful!", "Great air here today!"],
    2 => ["Air quality is fine.", "Acceptable."],
    3 => ["Well… It’s been better.", "Above daily WHO recommendations."],
    4 => ["Poor air quality!", "Bad air quality!"],
    5 => ["Air pollution is way over the limit.", "ExtremAIRly poor."],
    6 => ["AIRmageddon!", "DisAIRster!"],
  }
  
  def get_measurements(latitude, longitude) do
    with {:ok, %{"currentMeasurements" => data}} <- Airlyapi.get_map_point_measurements(latitude, longitude) do
      measurements_to_text(data)
    else
      {:error, reason} -> Logger.error(reason)
    end
  end
  
  defp measurements_to_text(data) do
    [to_message(:caqi, data["airQualityIndex"], data["pollutionLevel"]),
     to_message(:pm25, data["pm25"]),
     to_message(:pm10, data["pm10"]),
     to_message(:temp, data["temperature"])]
    |> Enum.join("\n")
  end
  
  defp to_message(:pm25, data), do: "*PM25*: #{percentage_of_norm(data, @pm25_norm)}"
  defp to_message(:pm10, data), do: "*PM10*: #{percentage_of_norm(data, @pm10_norm)}"
  defp to_message(:temp, nil), do:  "*Temperature*:"
  defp to_message(:temp, data), do: "*Temperature*: #{round(data)}°C"
  defp to_message(:caqi, caqi, level), do: "*CAQI*: #{if caqi, do: round(caqi)} *#{if level, do: @pollution_level[level] |> Enum.random()}*"
  
  defp percentage_of_norm(nil, _), do: ""
  defp percentage_of_norm(data, norm) do
    data / norm * 100
    |> Float.round(2)
    |> to_string
    |> Kernel.<>("%")
  end
end