defmodule Krksmogbot.Commands do
    require Logger
    alias Krksmogbot.Measurements

    @start_msg Path.expand("resources/start.md") |> File.read!
    @legend_msg Path.expand("resources/legend.md") |> File.read!
    @help_msg Path.expand("resources/help.md") |> File.read!
    @keyboard %Nadia.Model.ReplyKeyboardMarkup{keyboard: [[%{text: "Check my location",
                                                             request_location: true}],
                                                          [%{text: "Check city center"}]],
                                               resize_keyboard: true}
    @city_center_coords %{latitude: 50.0611127, longitude: 19.9379205}

    def match(%{message: msg} = input) do
        case msg do
            %{text: "/start"} -> @start_msg |> send_message_with_keyboard(msg)
            %{text: "/legend"} -> @legend_msg |> send_message_with_keyboard(msg)
            %{location: %{latitude: lat, longitude: lng}, message_id: msg_id} -> Measurements.get_measurements(lat, lng) |> send_message_with_keyboard(msg, [reply_to_message_id: msg_id])
            %{text: "Check city center"} -> 
                input.message.location
                |> put_in(@city_center_coords)
                |> match
            _ -> @help_msg |> send_message_with_keyboard(msg)
        end
    end
    def match(backoff), do: Logger.log :error, "Unmatched message #{inspect(backoff)}"
    
    defp send_message_with_keyboard(text, %{chat: %{id: chat_id}}, options \\ []) do
        Nadia.send_message(chat_id, text,
                            [parse_mode: "Markdown",
                             disable_web_page_preview: true,
                             reply_markup: @keyboard] ++ options)
    end
end