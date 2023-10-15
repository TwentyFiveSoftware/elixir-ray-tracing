defmodule ElixirRayTracing do
  @width 300
  @height 200
  @max_ray_recursive_depth 50
  @samples_per_pixel 100

  @camera Camera.new_camera(%Vector3{x: 12.0, y: 2.0, z: 3.0}, %Vector3{}, 25.0, @width, @height)
  @spheres [
    %Sphere{
      center: %Vector3{x: 0.0, y: 0.0, z: 1.0},
      radius: 0.5,
      material: %Material{type: :diffuse, albedo: %Vector3{x: 0.9, y: 0.9, z: 0.9}}
    },
    %Sphere{
      center: %Vector3{x: -1.0, y: 0.0, z: 1.0},
      radius: 0.5,
      material: %Material{type: :metal, albedo: %Vector3{x: 0.9, y: 0.9, z: 0.9}}
    },
    %Sphere{
      center: %Vector3{x: 1.0, y: 0.0, z: 1.0},
      radius: 0.5,
      material: %Material{type: :dielectric, refraction_index: 1.5}
    }
  ]

  def main do
    pixels = ray_trace()
    Image.save_as_png("./render.png", @width, @height, pixels)
  end

  @spec ray_trace() :: [%Vector3{}]
  def ray_trace() do
    for y <- 0..(@height - 1), x <- 0..(@width - 1) do
      accumulated_pixel_color =
        Enum.reduce(1..@samples_per_pixel, %Vector3{}, fn _, color ->
          Vector3.vector_add(color, calculate_pixel_color(x, y))
        end)

      Vector3.vector_mul_scalar(accumulated_pixel_color, 1.0 / @samples_per_pixel)
    end
  end

  @spec calculate_pixel_color(integer(), integer()) :: %Vector3{}
  def calculate_pixel_color(x, y) do
    u = (x + :rand.uniform()) / (@width - 1)
    v = (y + :rand.uniform()) / (@height - 1)

    ray = Camera.get_camera_ray(@camera, u, v)
    Ray.ray_color(ray, @spheres, 0, @max_ray_recursive_depth)
  end
end
