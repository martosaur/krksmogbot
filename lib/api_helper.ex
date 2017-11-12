defmodule API.Helper do
    def config_or_env(key) do
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