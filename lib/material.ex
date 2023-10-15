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
    scattered_ray = %Ray{origin: hit_record.point, direction: hit_record.normal}

    %ScatterRecord{
      does_scatter: true,
      attenuation: hit_record.material.albedo,
      scattered_ray: scattered_ray
    }
  end
end
