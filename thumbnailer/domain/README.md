# 3D Model Top-Down Thumbnailer

A pure Java command-line application built with Maven that generates top-down PNG previews of 3D `.stl` and `.3mf` models.

## Features

- **Top-Down Orthographic Rendering**: Renders models directly from the top camera angle, centered with clean margins so the entire model is visible.
- **STL & 3MF Support**: Automatically detects and reads ASCII/Binary `.stl` files and `.3mf` archives (including component transforms, production `p:path` sub-models, and color groups).
- **Software Rasterizer with Z-Buffer**: No native OpenGL, X11, or GPU dependencies needed—runs anywhere seamlessly headless.
- **Blinn-Phong Lighting**: Renders directional diffuse and specular highlights so contours and depth are clearly visible.
- **2x Super-Sample Anti-Aliasing (SSAA)**: Produces crisp, smooth edges.

## Building

```bash
mvn clean package
```

## Running

Generate PNG previews for all `.stl` and `.3mf` files in the current directory:

```bash
java -jar target/thumbnailer-1.0.0.jar
```

Or using Maven exec plugin:

```bash
mvn exec:java
```

### Options

```text
3D Model Top-Down Thumbnailer (.stl, .3mf)
Usage:
  java -jar thumbnailer.jar [options] [directory]

Options:
  -d, --dir <path>     Directory containing .stl or .3mf files (default: current directory)
  -f, --file <path>    Process a single .stl or .3mf file
  -s, --size <pixels>  Width/height of generated PNG preview (default: 800)
      --no-aa          Disable Super-Sample Anti-Aliasing
  -h, --help           Show this help message
```
