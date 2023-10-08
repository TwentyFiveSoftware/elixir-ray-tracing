defmodule Ray do
  defstruct origin: %Vector3{}, direction: %Vector3{}

  @spec calculate_ray_collision(Ray, [Sphere]) :: HitRecord
  def calculate_ray_collision(ray, spheres) do
    collisions =
      Enum.map(spheres, fn sphere -> Sphere.ray_hits_sphere(ray, sphere) end)
      |> Enum.filter(fn hit_record -> hit_record.hit end)
      |> Enum.sort(fn a, b -> a.t >= b.t end)

    case collisions do
      [] -> %HitRecord{}
      [first | _] -> first
    end
  end
end
