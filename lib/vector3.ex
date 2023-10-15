require Math

defmodule Vector3 do
  defstruct x: 0.0, y: 0.0, z: 0.0

  @epsilon 1.0e-8

  @spec vector_add(%Vector3{}, %Vector3{}) :: %Vector3{}
  def vector_add(a, b) do
    %Vector3{x: a.x + b.x, y: a.y + b.y, z: a.z + b.z}
  end

  @spec vector_sub(%Vector3{}, %Vector3{}) :: %Vector3{}
  def vector_sub(a, b) do
    %Vector3{x: a.x - b.x, y: a.y - b.y, z: a.z - b.z}
  end

  @spec vector_mul_scalar(%Vector3{}, float()) :: %Vector3{}
  def vector_mul_scalar(v, scalar) do
    %Vector3{x: v.x * scalar, y: v.y * scalar, z: v.z * scalar}
  end

  @spec vector_mul(%Vector3{}, %Vector3{}) :: %Vector3{}
  def vector_mul(a, b) do
    %Vector3{x: a.x * b.x, y: a.y * b.y, z: a.z * b.z}
  end

  @spec vector_dot(%Vector3{}, %Vector3{}) :: float()
  def vector_dot(a, b) do
    a.x * b.x + a.y * b.y + a.z * b.z
  end

  @spec vector_length_squared(%Vector3{}) :: float()
  def vector_length_squared(v) do
    v.x * v.x + v.y * v.y + v.z * v.z
  end

  @spec vector_length(%Vector3{}) :: float()
  def vector_length(v) do
    Math.sqrt(vector_length_squared(v))
  end

  @spec vector_neg(%Vector3{}) :: %Vector3{}
  def vector_neg(v) do
    %Vector3{x: -v.x, y: -v.y, z: -v.z}
  end

  @spec vector_normalize(%Vector3{}) :: %Vector3{}
  def vector_normalize(v) do
    v_length = vector_length(v)

    if v_length == 0 do
      IO.write("yes")
      v
    else
      %Vector3{x: v.x / v_length, y: v.y / v_length, z: v.z / v_length}
    end
  end

  @spec lerp(%Vector3{}, %Vector3{}, float()) :: %Vector3{}
  def lerp(a, b, t) do
    %Vector3{
      x: a.x * (1.0 - t) + b.x * t,
      y: a.y * (1.0 - t) + b.y * t,
      z: a.z * (1.0 - t) + b.z * t
    }
  end

  @spec random_unit_vector() :: %Vector3{}
  def random_unit_vector do
    v = %Vector3{
      x: :rand.uniform() * 2.0 - 1.0,
      y: :rand.uniform() * 2.0 - 1.0,
      z: :rand.uniform() * 2.0 - 1.0
    }

    if vector_length_squared(v) < 1.0 do
      vector_normalize(v)
    else
      random_unit_vector()
    end
  end

  @spec vector_is_near_zero(%Vector3{}) :: boolean()
  def vector_is_near_zero(v) do
    abs(v.x) < @epsilon and abs(v.y) < @epsilon and abs(v.z) < @epsilon
  end
end
