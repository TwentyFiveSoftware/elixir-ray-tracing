defmodule Camera do
  defstruct origin: %Vector3{},
            upper_left_corner: %Vector3{},
            viewport_width: 1,
            viewport_height: 1

  @spec new_camera(%Vector3{}, float(), float(), float()) :: %Camera{}
  def new_camera(origin, viewport_width, viewport_height, focal_length) do
    %Camera{
      origin: origin,
      upper_left_corner: %Vector3{
        x: viewport_width * -0.5 - origin.x,
        y: viewport_height * 0.5 - origin.y,
        z: focal_length - origin.z
      },
      viewport_width: viewport_width,
      viewport_height: viewport_height
    }
  end

  @spec ray_from_camera_to_uv(%Camera{}, float(), float()) :: %Ray{}
  def ray_from_camera_to_uv(camera, u, v) do
    %Ray{
      origin: camera.origin,
      direction: %Vector3{
        x: camera.upper_left_corner.x + camera.viewport_width * u,
        y: camera.upper_left_corner.y - camera.viewport_height * v,
        z: camera.upper_left_corner.z
      }
    }
  end
end
