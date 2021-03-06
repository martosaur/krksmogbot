defmodule Krksmogbot.Mixfile do
  use Mix.Project

  def project do
    [
      app: :krksmogbot,
      version: "0.3.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        krksmogbot: [
          include_executablesfor: [:unix]
        ]
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [extra_applications: [:logger], mod: {Krksmogbot, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:nadia, git: "https://github.com/zhyu/nadia.git"},
      {:httpoison, "~> 1.5.1"},
      {:plug_cowboy, "~> 2.1"},
      {:jason, "~> 1.1"}
    ]
  end
end
