defmodule Color do
  @spec random_color() :: %Vector3{}
  def random_color do
    hsv_to_rgb(Enum.random(0..360), 0.75, 0.45)
  end

  @spec hsv_to_rgb(integer(), float(), float()) :: %Vector3{}
  defp hsv_to_rgb(h, s, v) do
    h = if h == 360, do: 0, else: h / 60.0
    fract = h - floor(h)

    p = v * (1.0 - s)
    q = v * (1.0 - s * fract)
    t = v * (1.0 - s * (1.0 - fract))

    {r, g, b} =
      cond do
        0 <= h and h < 1 -> {v, t, p}
        1 <= h and h < 2 -> {q, v, p}
        2 <= h and h < 3 -> {p, v, t}
        3 <= h and h < 4 -> {p, q, v}
        4 <= h and h < 5 -> {t, p, v}
        5 <= h and h < 6 -> {v, p, q}
        true -> {0, 0, 0}
      end

    %Vector3{x: r, y: g, z: b}
  end
end
