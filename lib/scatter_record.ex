defmodule ScatterRecord do
  defstruct does_scatter: false, attenuation: %Vector3{}, scattered_ray: %Ray{}
end
