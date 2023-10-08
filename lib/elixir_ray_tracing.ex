defmodule ElixirRayTracing do
  @width 300
  @height 200

  @aspect_ratio @width / @height
  @viewport_height 2.0
  @viewport_width @viewport_height * @aspect_ratio

  @camera Camera.new_camera(%Vector3{}, @viewport_width, @viewport_height, 1.0)
  @spheres [%Sphere{center: %Vector3{z: 1}, radius: 0.5}]

  def main do
    pixels = ray_trace()
    Image.save_as_png("./render.png", @width, @height, pixels)
  end

  @spec ray_trace() :: [Vector3]
  def ray_trace() do
    for y <- 0..(@height - 1), x <- 0..(@width - 1), do: calculate_pixel_color(x, y)
  end

  @spec calculate_pixel_color(integer, integer) :: Vector3
  def calculate_pixel_color(x, y) do
    u = x / (@width - 1)
    v = y / (@height - 1)

    ray = Camera.ray_from_camera_to_uv(@camera, u, v)
    ray_color(ray)
  end

  @spec ray_color(Ray) :: Vector3
  def ray_color(ray) do
    t = (Vector3.vector_normalize(ray.direction).y + 1.0) * 0.5
    %Vector3{x: t, y: t, z: t}
  end
end
