defmodule Krksmogbot.Processor do
  require Logger
  
  def process_message(nil), do: Logger.error("Proccessor received nil")
  def process_message(message) do
    try do
      Task.start(Botan, :track, [message])
      Krksmogbot.Commands.match(message)
    rescue
      error -> Logger.warn(error)
    end
  end
end