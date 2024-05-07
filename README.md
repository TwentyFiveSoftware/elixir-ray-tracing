# Ray Tracing

<img src="https://github.com/TwentyFiveSoftware/ray-tracing-gpu/blob/master/sceneRender.png">

## Overview

This is my take on [Peter Shirley's Ray Tracing in One Weekend](https://github.com/RayTracing/raytracing.github.io) book.

This project uses the [Elixir](https://elixir-lang.org/) programming language, which is a dynamic, functional language for building scalable applications.

## Build & Run this project

1. Install [Elixir](https://elixir-lang.org/install.html)
2. Clone the repository
3. Optional: Change sample count in `lib/elixir_ray_tracing.ex`
4. Build the project
   ```sh
   MIX_ENV=prod mix release
   ```
5. Run the application
   ```sh
   ./_build/prod/rel/elixir_ray_tracing/bin/elixir_ray_tracing eval "ElixirRayTracing.main()"
   ```

## Performance

I've already implemented Peter Shirley's ray tracing in various programming languages running on CPU & GPU and compared their performance.

The performance was measured on the same scene (see image above) with the same amount of objects, the same recursive
depth, the same resolution (1920 x 1080). The measured times are averaged over multiple runs.

*Reference system: AMD Ryzen 9 5900X (12 Cores / 24 Threads) | AMD Radeon RX 6800 XT*

|                                                                                                    | 1 sample / pixel | 100 samples / pixel | 
|----------------------------------------------------------------------------------------------------|-----------------:|--------------------:|
| [Elixir](https://github.com/TwentyFiveSoftware/elixir-ray-tracing)                                 |        67,200 ms |                 N/A |
| [JavaScript - Node.js](https://github.com/TwentyFiveSoftware/javascript-ray-tracing)               |         4,870 ms |               308 s |
| [Go](https://github.com/TwentyFiveSoftware/go-ray-tracing)                                         |         1,410 ms |               142 s |
| [Java](https://github.com/TwentyFiveSoftware/java-ray-tracing)                                     |           770 ms |                59 s |
| [C++](https://github.com/TwentyFiveSoftware/ray-tracing)                                           |           685 ms |                70 s |
| [Rust](https://github.com/TwentyFiveSoftware/rust-ray-tracing)                                     |           362 ms |                36 s |
| [C](https://github.com/TwentyFiveSoftware/c-ray-tracing)                                           |           329 ms |                33 s |
| [GPU - Compute Shader](https://github.com/TwentyFiveSoftware/ray-tracing-gpu)                      |            21 ms |                 2 s |
| [GPU - Vulkan Ray Tracing Extension](https://github.com/TwentyFiveSoftware/ray-tracing-gpu-vulkan) |             1 ms |               0.1 s |
