#!/usr/bin/env python3
"""
STL Top-Down Preview Generator

Renders top-down PNG previews of 3D STL (ASCII and Binary) files.
Can be executed as a command-line tool or imported as a Python module.
"""

import argparse
import os
import re
import struct
import sys
from pathlib import Path
from typing import Optional, Tuple, Union

import numpy as np
from PIL import Image, ImageDraw


def parse_stl_binary(filepath: Union[str, Path]) -> Tuple[np.ndarray, np.ndarray]:
    """
    Parse a binary STL file into vertex coordinates and facet normals.

    Returns:
        verts: ndarray of shape (N, 3, 3) representing N triangles with 3 vertices in (x, y, z).
        normals: ndarray of shape (N, 3) representing N facet normals.
    """
    filepath = Path(filepath)
    file_size = filepath.stat().st_size
    if file_size < 84:
        raise ValueError(f"File too small for binary STL: {file_size} bytes")

    with open(filepath, "rb") as f:
        header = f.read(80)
        num_triangles_bytes = f.read(4)
        num_triangles = struct.unpack("<I", num_triangles_bytes)[0]

        expected_size = 84 + 50 * num_triangles
        if file_size != expected_size:
            raise ValueError(
                f"Binary STL size mismatch: header specifies {num_triangles} triangles "
                f"(expected {expected_size} bytes), but file is {file_size} bytes"
            )

        tri_dtype = np.dtype(
            [
                ("normal", "<f4", (3,)),
                ("v0", "<f4", (3,)),
                ("v1", "<f4", (3,)),
                ("v2", "<f4", (3,)),
                ("attr", "<u2"),
            ]
        )
        data = np.fromfile(f, dtype=tri_dtype, count=num_triangles)

    normals = np.ascontiguousarray(data["normal"], dtype=np.float32)
    verts = np.stack([data["v0"], data["v1"], data["v2"]], axis=1).astype(np.float32)
    return verts, normals


def parse_stl_ascii(filepath: Union[str, Path]) -> Tuple[np.ndarray, np.ndarray]:
    """
    Parse an ASCII STL file into vertex coordinates and facet normals.

    Returns:
        verts: ndarray of shape (N, 3, 3) representing N triangles with 3 vertices in (x, y, z).
        normals: ndarray of shape (N, 3) representing N facet normals.
    """
    with open(filepath, "r", errors="ignore") as f:
        text = f.read()

    # Fast regex parsing for vertex coordinates and facet normals
    normal_matches = re.findall(
        r"facet\s+normal\s+([-\d.eE+]+)\s+([-\d.eE+]+)\s+([-\d.eE+]+)",
        text,
        re.IGNORECASE,
    )
    vertex_matches = re.findall(
        r"vertex\s+([-\d.eE+]+)\s+([-\d.eE+]+)\s+([-\d.eE+]+)",
        text,
        re.IGNORECASE,
    )

    if not vertex_matches:
        return np.empty((0, 3, 3), dtype=np.float32), np.empty((0, 3), dtype=np.float32)

    # Truncate to multiple of 3 if needed
    num_verts = len(vertex_matches) - (len(vertex_matches) % 3)
    vertex_matches = vertex_matches[:num_verts]
    num_triangles = num_verts // 3

    verts = np.array(vertex_matches, dtype=np.float32).reshape(num_triangles, 3, 3)

    if len(normal_matches) >= num_triangles:
        normals = np.array(normal_matches[:num_triangles], dtype=np.float32)
    else:
        # Compute normals via cross product
        v0, v1, v2 = verts[:, 0, :], verts[:, 1, :], verts[:, 2, :]
        normals = np.cross(v1 - v0, v2 - v0)
        norm_len = np.linalg.norm(normals, axis=1, keepdims=True)
        norm_len[norm_len == 0] = 1.0
        normals = normals / norm_len

    return verts, normals


def load_stl(filepath: Union[str, Path]) -> Tuple[np.ndarray, np.ndarray]:
    """
    Load an STL file (ASCII or Binary) automatically.

    Returns:
        verts: ndarray of shape (N, 3, 3)
        normals: ndarray of shape (N, 3)
    """
    filepath = Path(filepath)
    if not filepath.is_file():
        raise FileNotFoundError(f"STL file not found: {filepath}")

    # Check for binary STL signature
    file_size = filepath.stat().st_size
    if file_size >= 84:
        with open(filepath, "rb") as f:
            header = f.read(84)
            num_triangles = struct.unpack("<I", header[80:84])[0]
            if file_size == 84 + 50 * num_triangles:
                try:
                    return parse_stl_binary(filepath)
                except Exception:
                    pass

    # Fallback to ASCII STL parser
    return parse_stl_ascii(filepath)


def parse_color(color_spec: Union[str, Tuple[int, ...]]) -> Tuple[int, int, int, int]:
    """
    Parse a color string (e.g. 'transparent', '#D7AF37', '#RRGGBBAA', 'white', or RGB tuple)
    into an RGBA 4-tuple.
    """
    if isinstance(color_spec, (tuple, list)):
        if len(color_spec) == 3:
            return (int(color_spec[0]), int(color_spec[1]), int(color_spec[2]), 255)
        elif len(color_spec) == 4:
            return (
                int(color_spec[0]),
                int(color_spec[1]),
                int(color_spec[2]),
                int(color_spec[3]),
            )

    c = str(color_spec).strip().lower()
    if c in ("transparent", "none", "clear"):
        return (255, 255, 255, 0)
    if c == "white":
        return (255, 255, 255, 255)
    if c == "black":
        return (0, 0, 0, 255)
    if c == "gray" or c == "grey":
        return (128, 128, 128, 255)
    if c.startswith("#"):
        hex_val = c.lstrip("#")
        if len(hex_val) == 6:
            r = int(hex_val[0:2], 16)
            g = int(hex_val[2:4], 16)
            b = int(hex_val[4:6], 16)
            return (r, g, b, 255)
        elif len(hex_val) == 8:
            r = int(hex_val[0:2], 16)
            g = int(hex_val[2:4], 16)
            b = int(hex_val[4:6], 16)
            a = int(hex_val[6:8], 16)
            return (r, g, b, a)

    # Named presets
    presets = {
        "gold": (218, 165, 32, 255),
        "sandstone": (215, 175, 55, 255),
        "slate": (175, 190, 205, 255),
        "cyan": (64, 165, 225, 255),
        "silver": (200, 200, 200, 255),
    }
    if c in presets:
        return presets[c]

    # Default fallback
    return (215, 175, 55, 255)


def render_top_down_image(
    verts: np.ndarray,
    normals: np.ndarray,
    width: int = 512,
    height: int = 512,
    model_color: Union[str, Tuple[int, ...]] = (215, 175, 55),
    bg_color: Union[str, Tuple[int, ...]] = "transparent",
    margin_ratio: float = 0.08,
    supersample: int = 2,
    light_direction: Tuple[float, float, float] = (-0.35, -0.45, 0.82),
    ambient: float = 0.35,
) -> Image.Image:
    """
    Render a top-down view of 3D STL vertices to a PIL Image.

    The top-down camera looks straight down along the Z-axis (from +Z to -Z).
    Model X maps to horizontal screen axis, and Model Y maps to vertical screen axis.
    The view scales uniformly to fit the entire model within the specified image bounds
    while strictly preserving aspect ratio and centering the model.

    Args:
        verts: ndarray of shape (N, 3, 3)
        normals: ndarray of shape (N, 3)
        width: Output image width in pixels
        height: Output image height in pixels
        model_color: Base RGB or RGBA color for the 3D surface
        bg_color: Background color (e.g. 'transparent', 'white', or RGBA tuple)
        margin_ratio: Margin fraction around the model bounding box (default 8%)
        supersample: Anti-aliasing supersample factor (e.g. 2 for 2x SSAA)
        light_direction: Direction of key light (dx, dy, dz)
        ambient: Ambient light coefficient (0.0 to 1.0)

    Returns:
        PIL.Image in RGBA format.
    """
    target_size = (max(16, int(width)), max(16, int(height)))
    ss = max(1, int(supersample))
    render_w = target_size[0] * ss
    render_h = target_size[1] * ss

    parsed_bg = parse_color(bg_color)
    parsed_model_rgb = parse_color(model_color)[:3]

    if len(verts) == 0:
        # Return empty image with background color
        return Image.new("RGBA", target_size, parsed_bg)

    # Recompute or normalize normals
    norm_len = np.linalg.norm(normals, axis=1, keepdims=True)
    zero_normals = norm_len.squeeze() == 0
    if np.any(zero_normals):
        v0 = verts[zero_normals, 0, :]
        v1 = verts[zero_normals, 1, :]
        v2 = verts[zero_normals, 2, :]
        calc_normals = np.cross(v1 - v0, v2 - v0)
        calc_len = np.linalg.norm(calc_normals, axis=1, keepdims=True)
        calc_len[calc_len == 0] = 1.0
        normals[zero_normals] = calc_normals / calc_len
        norm_len = np.linalg.norm(normals, axis=1, keepdims=True)
        norm_len[norm_len == 0] = 1.0

    unit_normals = normals / norm_len

    # Two-sided lighting: for visible facets facing upward or downward,
    # orient normals toward the camera (+Z) to shade inverted facets cleanly
    flip_mask = unit_normals[:, 2] < 0
    effective_normals = unit_normals.copy()
    effective_normals[flip_mask] = -effective_normals[flip_mask]

    # Calculate bounding box in XY plane
    all_x = verts[:, :, 0].flatten()
    all_y = verts[:, :, 1].flatten()
    all_z = verts[:, :, 2].flatten()

    min_x, max_x = float(all_x.min()), float(all_x.max())
    min_y, max_y = float(all_y.min()), float(all_y.max())

    span_x = max(max_x - min_x, 1e-6)
    span_y = max(max_y - min_y, 1e-6)

    # Padding to guarantee whole model is visible within margins
    pad_x = render_w * margin_ratio
    pad_y = render_h * margin_ratio
    usable_w = max(render_w - 2 * pad_x, 1.0)
    usable_h = max(render_h - 2 * pad_y, 1.0)

    # Uniform scale preserving aspect ratio
    scale = min(usable_w / span_x, usable_h / span_y)

    model_cx = (min_x + max_x) / 2.0
    model_cy = (min_y + max_y) / 2.0
    img_cx = render_w / 2.0
    img_cy = render_h / 2.0

    # Project to screen coordinates:
    # 3D X -> screen X: (x - cx) * scale + img_cx
    # 3D Y -> screen Y: img_cy - (y - cy) * scale (3D +Y is top of view)
    px = (verts[:, :, 0] - model_cx) * scale + img_cx
    py = img_cy - (verts[:, :, 1] - model_cy) * scale

    # Lighting calculation
    light_vec = np.array(light_direction, dtype=np.float32)
    light_norm = np.linalg.norm(light_vec)
    if light_norm > 0:
        light_vec /= light_norm
    else:
        light_vec = np.array([0.0, 0.0, 1.0], dtype=np.float32)

    diffuse = np.sum(effective_normals * light_vec, axis=1)
    diffuse = np.clip(diffuse, 0.0, 1.0)

    amb = float(np.clip(ambient, 0.0, 1.0))
    intensity = np.clip(amb + (1.0 - amb) * diffuse, 0.0, 1.0)

    base_rgb = np.array(parsed_model_rgb, dtype=np.float32)
    face_colors = (intensity[:, None] * base_rgb).astype(np.uint8)

    # Painter's algorithm: sort triangles by depth (mean Z) ascending
    pz = verts[:, :, 2]
    mean_z = pz.mean(axis=1)
    render_order = np.argsort(mean_z)

    # Create render surface (RGBA)
    render_img = Image.new("RGBA", (render_w, render_h), parsed_bg)
    draw = ImageDraw.Draw(render_img)

    for idx in render_order:
        p0 = (px[idx, 0], py[idx, 0])
        p1 = (px[idx, 1], py[idx, 1])
        p2 = (px[idx, 2], py[idx, 2])
        col = (
            int(face_colors[idx, 0]),
            int(face_colors[idx, 1]),
            int(face_colors[idx, 2]),
            255,
        )
        draw.polygon([p0, p1, p2], fill=col, outline=col)

    if ss > 1:
        # Downsample with high-quality anti-aliasing
        final_img = render_img.resize(target_size, Image.Resampling.LANCZOS)
    else:
        final_img = render_img

    return final_img


def generate_preview(
    stl_path: Union[str, Path],
    output_path: Optional[Union[str, Path]] = None,
    width: int = 512,
    height: int = 512,
    model_color: Union[str, Tuple[int, ...]] = (215, 175, 55),
    bg_color: Union[str, Tuple[int, ...]] = "transparent",
    margin_ratio: float = 0.08,
    supersample: int = 2,
    overwrite: bool = True,
) -> Path:
    """
    Generate a top-down PNG preview for a single STL file.

    Args:
        stl_path: Path to input STL file
        output_path: Optional path for output PNG. If omitted, uses <stl_stem>.png in same dir.
        width: Output image width (default: 512)
        height: Output image height (default: 512)
        model_color: Base color for the model surface
        bg_color: Background color
        margin_ratio: Margin around model bounds (default: 0.08)
        supersample: Supersampling anti-aliasing factor (default: 2)
        overwrite: Whether to overwrite existing output file

    Returns:
        Path of the generated PNG file.
    """
    stl_path = Path(stl_path).resolve()
    if output_path is None:
        output_path = stl_path.with_suffix(".png")
    else:
        output_path = Path(output_path).resolve()

    if output_path.exists() and not overwrite:
        return output_path

    output_path.parent.mkdir(parents=True, exist_ok=True)

    verts, normals = load_stl(stl_path)
    img = render_top_down_image(
        verts=verts,
        normals=normals,
        width=width,
        height=height,
        model_color=model_color,
        bg_color=bg_color,
        margin_ratio=margin_ratio,
        supersample=supersample,
    )
    img.save(output_path, format="PNG")
    return output_path


def find_stl_files(directory: Union[str, Path]) -> list[Path]:
    """
    Find all STL files in the given directory (case-insensitive for .stl extension).
    """
    target_dir = Path(directory)
    if not target_dir.is_dir():
        raise NotADirectoryError(f"Directory not found: {target_dir}")

    stl_files = []
    for item in target_dir.iterdir():
        if item.is_file() and item.suffix.lower() == ".stl":
            stl_files.append(item)
    return sorted(stl_files, key=lambda p: p.name)


def process_directory(
    directory: Union[str, Path] = ".",
    output_dir: Optional[Union[str, Path]] = None,
    width: int = 512,
    height: int = 512,
    model_color: Union[str, Tuple[int, ...]] = (215, 175, 55),
    bg_color: Union[str, Tuple[int, ...]] = "transparent",
    margin_ratio: float = 0.08,
    supersample: int = 2,
    overwrite: bool = True,
    quiet: bool = False,
) -> list[Path]:
    """
    Find every .stl file in `directory` and generate a top-down PNG preview.

    Args:
        directory: Directory containing STL files (defaults to current directory)
        output_dir: Optional destination directory for PNGs (defaults to input directory)
        width: Preview width
        height: Preview height
        model_color: Color preset or hex/RGB
        bg_color: Background color
        margin_ratio: Framing margin ratio
        supersample: Anti-aliasing factor
        overwrite: Whether to overwrite existing previews
        quiet: Suppress progress prints if True

    Returns:
        List of generated PNG Path objects.
    """
    dir_path = Path(directory).resolve()
    stl_files = find_stl_files(dir_path)

    out_dir = Path(output_dir).resolve() if output_dir else None
    generated_pngs = []

    if not quiet:
        print(f"Found {len(stl_files)} STL file(s) in {dir_path}")

    for idx, stl_file in enumerate(stl_files, start=1):
        if out_dir:
            out_png = out_dir / f"{stl_file.stem}.png"
        else:
            out_png = stl_file.with_suffix(".png")

        if not quiet:
            print(f"[{idx}/{len(stl_files)}] Rendering {stl_file.name} -> {out_png.name}...")

        try:
            res = generate_preview(
                stl_path=stl_file,
                output_path=out_png,
                width=width,
                height=height,
                model_color=model_color,
                bg_color=bg_color,
                margin_ratio=margin_ratio,
                supersample=supersample,
                overwrite=overwrite,
            )
            generated_pngs.append(res)
        except Exception as e:
            print(f"Error rendering {stl_file.name}: {e}", file=sys.stderr)

    if not quiet:
        print(f"Completed rendering {len(generated_pngs)} PNG preview(s).")

    return generated_pngs


def main():
    parser = argparse.ArgumentParser(
        description="Generate top-down PNG previews of 3D STL files."
    )
    parser.add_argument(
        "directory",
        nargs="?",
        default=".",
        help="Directory to search for STL files (defaults to current directory).",
    )
    parser.add_argument(
        "-f",
        "--file",
        dest="single_file",
        default=None,
        help="Render a specific single STL file instead of an entire directory.",
    )
    parser.add_argument(
        "-o",
        "--output-dir",
        default=None,
        help="Output directory to save PNG previews (defaults to the same directory as the STL file).",
    )
    parser.add_argument(
        "--size",
        type=int,
        default=512,
        help="Width and height of the generated preview PNG in pixels (default: 512).",
    )
    parser.add_argument(
        "--width",
        type=int,
        default=None,
        help="Image width in pixels (overrides --size).",
    )
    parser.add_argument(
        "--height",
        type=int,
        default=None,
        help="Image height in pixels (overrides --size).",
    )
    parser.add_argument(
        "--color",
        default="gold",
        help="Base color of the 3D model (preset like 'gold', 'sandstone', 'slate', or hex like '#D7AF37'). Default: gold.",
    )
    parser.add_argument(
        "--background",
        "--bg",
        default="transparent",
        help="Background color ('transparent', 'white', 'black', or hex '#RRGGBB'). Default: transparent.",
    )
    parser.add_argument(
        "--margin",
        type=float,
        default=0.08,
        help="Margin fraction around model bounds (default: 0.08).",
    )
    parser.add_argument(
        "--no-supersample",
        action="store_true",
        help="Disable 2x supersampling for faster rendering.",
    )
    parser.add_argument(
        "--no-overwrite",
        action="store_true",
        help="Skip rendering if destination PNG already exists.",
    )
    parser.add_argument(
        "-q",
        "--quiet",
        action="store_true",
        help="Quiet mode: suppress progress output.",
    )

    args = parser.parse_args()

    width = args.width if args.width is not None else args.size
    height = args.height if args.height is not None else args.size
    supersample = 1 if args.no_supersample else 2
    overwrite = not args.no_overwrite

    if args.single_file:
        stl_path = Path(args.single_file).resolve()
        if args.output_dir:
            out_path = Path(args.output_dir) / f"{stl_path.stem}.png"
        else:
            out_path = stl_path.with_suffix(".png")
        if not args.quiet:
            print(f"Rendering {stl_path} -> {out_path}...")
        res = generate_preview(
            stl_path=stl_path,
            output_path=out_path,
            width=width,
            height=height,
            model_color=args.color,
            bg_color=args.background,
            margin_ratio=args.margin,
            supersample=supersample,
            overwrite=overwrite,
        )
        if not args.quiet:
            print(f"Generated preview: {res}")
    else:
        process_directory(
            directory=args.directory,
            output_dir=args.output_dir,
            width=width,
            height=height,
            model_color=args.color,
            bg_color=args.background,
            margin_ratio=args.margin,
            supersample=supersample,
            overwrite=overwrite,
            quiet=args.quiet,
        )


if __name__ == "__main__":
    main()
