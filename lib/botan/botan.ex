defmodule Botan do
    use GenServer
    require Logger

    def start_link do
        Logger.log :info, "Started botan"
        GenServer.start_link __MODULE__, :ok, name: __MODULE__
    end

    def init(:ok) do
        {:ok, 0}
    end

    def track(message) do
        GenServer.cast __MODULE__, {:track, message}
    end

    def handle_cast({:track, message}, state) do
        case message do
            %{message: %{text: nil, from: %{username: uid}}} -> Botan.API.track(uid, "/location", message)
            %{message: %{text: text, from: %{username: uid}}} -> Botan.API.track(uid, text, message)
            r -> Logger.log :error, "Could not report following message: #{inspect(message)}"
        end
        {:noreply, state}
    end
end