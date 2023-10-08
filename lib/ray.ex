defmodule Ray do
  defstruct origin: %Vector3{}, direction: %Vector3{}

  @spec ray_at(%Ray{}, float()) :: %Vector3{}
  def ray_at(ray, t) do
    Vector3.vector_mul_scalar(ray.direction, t) |> Vector3.vector_add(ray.origin)
  end

  @spec ray_color(%Ray{}, [%Sphere{}], integer(), integer()) :: %Vector3{}
  def ray_color(ray, spheres, depth, max_ray_recursive_depth) do
    if depth >= max_ray_recursive_depth do
      %Vector3{x: 0.0, y: 0.0, z: 0.0}
    else
      hit_record = calculate_ray_collision(ray, spheres)

      if hit_record.hit do
        diffuse_ray = %Ray{origin: hit_record.point, direction: hit_record.normal}
        previous_ray_color = ray_color(diffuse_ray, spheres, depth + 1, max_ray_recursive_depth)
        Vector3.vector_mul(hit_record.material.albedo, previous_ray_color)
      else
        background_color(ray)
      end
    end
  end

  @spec background_color(%Ray{}) :: %Vector3{}
  def background_color(ray) do
    t = (Vector3.vector_normalize(ray.direction).y + 1.0) * 0.5
    Vector3.lerp(%Vector3{x: 1.0, y: 1.0, z: 1.0}, %Vector3{x: 0.5, y: 0.7, z: 1.0}, t)
  end

  @spec calculate_ray_collision(%Ray{}, [%Sphere{}]) :: HitRecord
  def calculate_ray_collision(ray, spheres) do
    collisions =
      Enum.map(spheres, fn sphere -> Sphere.ray_hits_sphere(ray, sphere, 0.001) end)
      |> Enum.filter(fn hit_record -> hit_record.hit and hit_record.t > 0.001 end)
      |> Enum.sort(fn a, b -> a.t >= b.t end)

    case collisions do
      [] -> %HitRecord{}
      [first | _] -> first
    end
  end
end
