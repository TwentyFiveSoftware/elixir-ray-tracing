require File
require Pngex

defmodule Image do
  @spec save_as_png(Path.t(), integer(), integer(), [%Vector3{}]) :: :ok
  def(save_as_png(path, width, height, pixels)) do
    bitmap =
      for pixel <- pixels do
        pixel_color = Vector3.vector_sqrt(pixel) |> Vector3.vector_mul_scalar(255.0)
        {trunc(pixel_color.x), trunc(pixel_color.y), trunc(pixel_color.z)}
      end

    image = generate_png(bitmap, width, height)
    File.write(path, image)
    :ok
  end

  defp generate_png(bitmap, width, height) do
    Pngex.new()
    |> Pngex.set_type(:rgb)
    |> Pngex.set_depth(:depth8)
    |> Pngex.set_size(width, height)
    |> Pngex.generate(bitmap)
  end
end
