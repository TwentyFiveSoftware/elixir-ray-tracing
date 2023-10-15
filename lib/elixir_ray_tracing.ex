defmodule ElixirRayTracing do
  @width 1920
  @height 1080
  @max_ray_recursive_depth 50
  @samples_per_pixel 1

  @camera Camera.new_camera(%Vector3{x: 12.0, y: 2.0, z: -3.0}, %Vector3{}, 25.0, @width, @height)
  @scene Scene.generate_scene()

  def main do
    {render_time, pixels} = :timer.tc(ElixirRayTracing, :ray_trace, [])
    IO.puts("rendered #{@samples_per_pixel} samples/pixel in #{render_time / 1000} ms")

    Image.save_as_png("./render.png", @width, @height, pixels)
  end

  @spec ray_trace() :: [%Vector3{}]
  def ray_trace() do
    rows =
      for y <- 0..(@height - 1) do
        IO.puts("#{y + 1} / #{@height}")

        tasks =
          for x <- 0..(@width - 1) do
            Task.async(ElixirRayTracing, :ray_trace_pixel, [x, y])
          end

        for task <- tasks do
          Task.await(task)
        end
      end

    List.flatten(rows)
  end

  @spec ray_trace_pixel(integer(), integer()) :: %Vector3{}
  def ray_trace_pixel(x, y) do
    accumulated_pixel_color =
      Enum.reduce(1..@samples_per_pixel, %Vector3{}, fn _, color ->
        Vector3.vector_add(color, calculate_pixel_color(x, y))
      end)

    Vector3.vector_mul_scalar(accumulated_pixel_color, 1.0 / @samples_per_pixel)
  end

  @spec calculate_pixel_color(integer(), integer()) :: %Vector3{}
  def calculate_pixel_color(x, y) do
    u = (x + :rand.uniform()) / (@width - 1)
    v = (y + :rand.uniform()) / (@height - 1)

    ray = Camera.get_camera_ray(@camera, u, v)
    Ray.ray_color(ray, @scene.spheres, 0, @max_ray_recursive_depth)
  end
end
