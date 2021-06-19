defmodule CredoStandalone.MixProject do
  use Mix.Project

  def project do
    [
      app: :credo_standalone,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [{:credo_standalone, release()}],
      preferred_cli_env: [release: :prod]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {CredoStandalone.Main, []}
    ]
  end

  defp deps do
    [
      {:bakeware, "~> 0.2.0", runtime: false},
      {:credo, "~> 1.5"}
    ]
  end

  defp release do
    [
      overwrite: true,
      steps: [:assemble, &Bakeware.assemble/1],
      strip_beams: Mix.env() == :prod
    ]
  end
end
