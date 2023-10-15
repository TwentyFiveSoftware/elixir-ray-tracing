defmodule Material do
  defstruct type: :diffuse, albedo: %Vector3{}

  @spec scatter(%HitRecord{}) :: %ScatterRecord{}
  def scatter(hit_record) do
    case hit_record.material.type do
      :diffuse -> scatter_diffuse_material(hit_record)
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
end
