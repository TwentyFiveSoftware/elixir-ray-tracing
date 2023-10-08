defmodule Sphere do
  defstruct center: %Vector3{}, radius: 1.0

  @spec ray_hits_sphere(Ray, Sphere) :: HitRecord
  def ray_hits_sphere(_ray, _sphere) do
    %HitRecord{}
  end
end
