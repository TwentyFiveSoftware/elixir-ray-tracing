require Math

defmodule Sphere do
  defstruct center: %Vector3{}, radius: 1.0, material: %Material{}

  @spec ray_hits_sphere(%Ray{}, %Sphere{}, float()) :: %HitRecord{}
  def ray_hits_sphere(ray, sphere, t_min) do
    oc = Vector3.vector_sub(ray.origin, sphere.center)
    a = Vector3.vector_length_squared(ray.direction)
    half_b = Vector3.vector_dot(oc, ray.direction)
    c = Vector3.vector_length_squared(oc) - sphere.radius * sphere.radius
    discriminant = half_b * half_b - a * c

    if discriminant < 0 do
      %HitRecord{}
    else
      sqrt_d = Math.sqrt(discriminant)
      root_1 = (-half_b - sqrt_d) / a
      root_2 = (-half_b + sqrt_d) / a

      t =
        cond do
          root_1 > t_min and root_1 < root_2 -> root_1
          root_2 > t_min -> root_2
          true -> -1.0
        end

      if t < 0 do
        %HitRecord{}
      else
        point = Ray.ray_at(ray, t)

        outward_normal =
          Vector3.vector_sub(point, sphere.center)
          |> Vector3.vector_mul_scalar(1.0 / sphere.radius)

        front_facing = Vector3.vector_dot(ray.direction, outward_normal) < 0.0
        normal = if front_facing, do: outward_normal, else: Vector3.vector_neg(outward_normal)

        %HitRecord{
          hit: true,
          t: t,
          point: point,
          normal: normal,
          front_facing: front_facing,
          material: sphere.material
        }
      end
    end
  end
end
