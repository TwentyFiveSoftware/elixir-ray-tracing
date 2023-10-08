require File
require Pngex

defmodule Image do
  @spec save_as_png(String, integer, integer, [Vector3]) :: none
  def(save_as_png(path, width, height, pixels)) do
    bitmap =
      for pixel <- pixels do
        {trunc(pixel.x * 0xFF), trunc(pixel.y * 0xFF), trunc(pixel.z * 0xFF)}
      end

    image = generate_png(bitmap, width, height)
    File.write(path, image)
  end

  defp generate_png(bitmap, width, height) do
    Pngex.new()
    |> Pngex.set_type(:rgb)
    |> Pngex.set_depth(:depth8)
    |> Pngex.set_size(width, height)
    |> Pngex.generate(bitmap)
  end
end
