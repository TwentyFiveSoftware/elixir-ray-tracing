defmodule HitRecord do
  defstruct hit: false,
            t: 0.0,
            point: %Vector3{},
            normal: %Vector3{},
            front_facing: true
end
