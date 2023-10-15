defmodule Material do
  defstruct type: :diffuse, albedo: %Vector3{}, refraction_index: 0.0

  @spec scatter(%HitRecord{}, %Ray{}) :: %ScatterRecord{}
  def scatter(hit_record, ray) do
    case hit_record.material.type do
      :diffuse -> scatter_diffuse_material(hit_record)
      :metal -> scatter_metal_material(hit_record, ray)
      :dielectric -> scatter_dielectric_material(hit_record, ray)
      _ -> %ScatterRecord{}
    end
  end

  @spec scatter_diffuse_material(%HitRecord{}) :: %ScatterRecord{}
  def scatter_diffuse_material(hit_record) do
    scatter_direction = Vector3.vector_add(hit_record.normal, Vector3.random_unit_vector())

    scatter_direction =
      if Vector3.vector_is_near_zero(scatter_direction),
        do: hit_record.normal,
        else: scatter_direction

    scattered_ray = %Ray{origin: hit_record.point, direction: scatter_direction}

    %ScatterRecord{
      does_scatter: true,
      attenuation: hit_record.material.albedo,
      scattered_ray: scattered_ray
    }
  end

  @spec scatter_metal_material(%HitRecord{}, %Ray{}) :: %ScatterRecord{}
  def scatter_metal_material(hit_record, ray) do
    scatter_direction =
      Vector3.vector_normalize(ray.direction) |> Vector3.vector_reflect(hit_record.normal)

    scattered_ray = %Ray{origin: hit_record.point, direction: scatter_direction}

    %ScatterRecord{
      does_scatter: Vector3.vector_dot(scatter_direction, hit_record.normal) > 0.0,
      attenuation: hit_record.material.albedo,
      scattered_ray: scattered_ray
    }
  end

  @spec scatter_dielectric_material(%HitRecord{}, %Ray{}) :: %ScatterRecord{}
  def scatter_dielectric_material(hit_record, ray) do
    refraction_ratio =
      if hit_record.front_facing,
        do: 1.0 / hit_record.material.refraction_index,
        else: hit_record.material.refraction_index

    scatter_direction =
      Vector3.vector_normalize(ray.direction)
      |> Vector3.vector_refract(hit_record.normal, refraction_ratio)

    scattered_ray = %Ray{origin: hit_record.point, direction: scatter_direction}

    %ScatterRecord{
      does_scatter: true,
      attenuation: %Vector3{x: 1.0, y: 1.0, z: 1.0},
      scattered_ray: scattered_ray
    }
  end
end
