defmodule Sequence.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sequence,
      version: "0.4.1",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Sequence.Application, []},
      env: [initial_number: 456],
      registered: [Sequence.Server]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exrm, "~> 1.0.0-rc7"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
