defmodule Krksmogbot.Matcher do
    use GenServer
    require Logger
    alias Krksmogbot.Commands

    def start_link do
        Logger.log :info, "Started matcher"
        GenServer.start_link __MODULE__, :ok, name: __MODULE__
    end

    def init(:ok) do
        {:ok, 0}
    end

    def handle_cast({:match, message}, state) do
        Commands.match(message)
        {:noreply, state}
    end

    def match(message) do
        GenServer.cast __MODULE__, {:match, message}
    end
end