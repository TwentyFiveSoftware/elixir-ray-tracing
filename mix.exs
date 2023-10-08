defmodule ElixirRayTracing.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_ray_tracing,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:math, "~> 0.6.0"},
      {:pngex, "~> 0.1.0"}
    ]
  end
end
