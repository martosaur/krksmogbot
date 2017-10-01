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

    def match(%{message: %{chat: %{id: chat_id}, text: "/start"}}) do
        Nadia.send_message(chat_id, @start_msg,
                           [parse_mode: "Markdown",
                            disable_web_page_preview: true,
                            reply_markup: @keyboard])
    end
    def match(%{message: %{chat: %{id: chat_id}, text: "/legend"}}) do
        Nadia.send_message(chat_id, @legend_msg,
                           [parse_mode: "Markdown",
                            disable_web_page_preview: true,
                            reply_markup: @keyboard])
    end
    def match(%{message: %{chat: %{id: chat_id}, message_id: msg_id, location: %{latitude: lat, longitude: lng}}}) do
        Nadia.send_message(chat_id, Measurements.get_measurements(lat, lng),
                           [parse_mode: "Markdown",
                            disable_web_page_preview: true,
                            reply_to_message_id: msg_id])
    end
    def match(%{message: %{chat: %{id: chat_id}, text: "Check city center"}} = msg) do
        msg.message.location
        |> put_in(@city_center_coords)
        |> match
    end
    def match(%{message: %{chat: %{id: chat_id}}}) do
        Nadia.send_message(chat_id, @help_msg,
                           [parse_mode: "Markdown",
                            disable_web_page_preview: true,
                            reply_markup: @keyboard])
    end
    def match(backoff), do: Logger.log :error, "Unmatched message #{Poison.encode!(backoff)}"
end