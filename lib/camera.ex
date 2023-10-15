defmodule Camera do
  defstruct look_from: %Vector3{},
            upper_left_corner: %Vector3{},
            horizontal_direction: %Vector3{},
            vertical_direction: %Vector3{}

  @spec new_camera(%Vector3{}, %Vector3{}, float(), integer(), integer()) :: %Camera{}
  def new_camera(look_from, look_at, fov, width, height) do
    aspect_ratio = width / height
    viewport_height = Math.tan(fov / 360.0 * Math.pi()) * 2.0
    viewport_width = viewport_height * aspect_ratio

    forward = Vector3.vector_sub(look_at, look_from) |> Vector3.vector_normalize()
    right = Vector3.vector_cross(%Vector3{y: 1.0}, forward) |> Vector3.vector_normalize()
    up = Vector3.vector_cross(forward, right) |> Vector3.vector_normalize()

    horizontal_direction = Vector3.vector_mul_scalar(right, viewport_width)
    vertical_direction = Vector3.vector_mul_scalar(up, viewport_height)

    upper_left_corner =
      Vector3.vector_sub(look_from, Vector3.vector_mul_scalar(horizontal_direction, 0.5))
      |> Vector3.vector_add(Vector3.vector_mul_scalar(vertical_direction, 0.5))
      |> Vector3.vector_add(forward)

    %Camera{
      look_from: look_from,
      upper_left_corner: upper_left_corner,
      horizontal_direction: horizontal_direction,
      vertical_direction: vertical_direction
    }
  end

  @spec get_camera_ray(%Camera{}, float(), float()) :: %Ray{}
  def get_camera_ray(camera, u, v) do
    target =
      Vector3.vector_mul_scalar(camera.horizontal_direction, u)
      |> Vector3.vector_add(camera.upper_left_corner)
      |> Vector3.vector_sub(Vector3.vector_mul_scalar(camera.vertical_direction, v))

    %Ray{
      origin: camera.look_from,
      direction: Vector3.vector_sub(target, camera.look_from)
    }
  end
end
