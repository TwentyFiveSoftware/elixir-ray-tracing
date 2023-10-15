defmodule Scene do
  defstruct spheres: []

  @spec generate_scene() :: %Scene{}
  def generate_scene do
    spheres =
      for x <- -11..11, z <- -11..11 do
        center = %Vector3{x: x + :rand.uniform() * 0.7, y: 0.2, z: z + :rand.uniform() * 0.7}

        material_random = :rand.uniform()

        case material_random do
          m when m < 0.05 ->
            %Sphere{
              center: center,
              radius: 0.2,
              material: %Material{type: :dielectric, refraction_index: 1.5}
            }

          m when m < 0.2 ->
            %Sphere{
              center: center,
              radius: 0.2,
              material: %Material{type: :metal, albedo: [Color.random_color()]}
            }

          _ ->
            %Sphere{
              center: center,
              radius: 0.2,
              material: %Material{type: :diffuse, albedo: [Color.random_color()]}
            }
        end
      end

    ground_sphere = %Sphere{
      center: %Vector3{x: 0.0, y: -1000.0, z: 1.0},
      radius: 1000.0,
      material: %Material{
        type: :diffuse,
        texture_type: :checkered,
        albedo: [%Vector3{x: 0.05, y: 0.05, z: 0.05}, %Vector3{x: 0.95, y: 0.95, z: 0.95}]
      }
    }

    center_sphere = %Sphere{
      center: %Vector3{x: 0.0, y: 1.0, z: 0.0},
      radius: 1.0,
      material: %Material{type: :dielectric, refraction_index: 1.5}
    }

    left_sphere = %Sphere{
      center: %Vector3{x: -4.0, y: 1.0, z: 0.0},
      radius: 1.0,
      material: %Material{type: :diffuse, albedo: [%Vector3{x: 0.6, y: 0.3, z: 0.1}]}
    }

    right_sphere = %Sphere{
      center: %Vector3{x: 4.0, y: 1.0, z: 0.0},
      radius: 1.0,
      material: %Material{type: :metal, albedo: [%Vector3{x: 0.7, y: 0.6, z: 0.5}]}
    }

    %Scene{spheres: [ground_sphere, center_sphere, left_sphere, right_sphere] ++ spheres}
  end
end
