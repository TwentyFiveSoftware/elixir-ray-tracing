defmodule ElixirRayTracing do
  def main do
    a = %Vector3{x: 1, y: 2, z: 3}
    b = %Vector3{x: 4, y: 5, z: 6}

    Vector3.vector_add(a, b) |> Vector3.vector_normalize() |> Vector3.vector_mul_scalar(5)
  end
end
