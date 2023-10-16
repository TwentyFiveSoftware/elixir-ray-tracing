defmodule ElixirRayTracing.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_ray_tracing,
      version: "1.0.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp deps do
    [
      {:math, "~> 0.6.0"},
      {:pngex, "~> 0.1.0"}
    ]
  end
end
