defmodule Krksmogbot.Processor do
  require Logger

  def process_message(nil), do: Logger.error("Proccessor received nil")

  def process_message(message) do
    Krksmogbot.Commands.match(message)
  end
end
