#!/usr/bin/env python3
"""
Unit and integration tests for STL Top-Down Preview Generator.
"""

import os
import shutil
import struct
import tempfile
import unittest
from pathlib import Path
from PIL import Image
import numpy as np

import render_stl_preview as rstl


class TestColorParsing(unittest.TestCase):
    def test_preset_names(self):
        gold = rstl.parse_color("gold")
        self.assertEqual(gold, (218, 165, 32, 255))
        white = rstl.parse_color("white")
        self.assertEqual(white, (255, 255, 255, 255))
        black = rstl.parse_color("black")
        self.assertEqual(black, (0, 0, 0, 255))
        transparent = rstl.parse_color("transparent")
        self.assertEqual(transparent, (255, 255, 255, 0))

    def test_hex_colors(self):
        hex_rgb = rstl.parse_color("#FF8000")
        self.assertEqual(hex_rgb, (255, 128, 0, 255))
        hex_rgba = rstl.parse_color("#12345678")
        self.assertEqual(hex_rgba, (0x12, 0x34, 0x56, 0x78))

    def test_tuple_input(self):
        rgb = rstl.parse_color((10, 20, 30))
        self.assertEqual(rgb, (10, 20, 30, 255))
        rgba = rstl.parse_color((10, 20, 30, 100))
        self.assertEqual(rgba, (10, 20, 30, 100))


class TestSTLParser(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.mkdtemp()

    def tearDown(self):
        shutil.rmtree(self.temp_dir, ignore_errors=True)

    def _create_synthetic_ascii_stl(self, filepath: Path):
        content = """solid test_triangle
  facet normal 0.0 0.0 1.0
    outer loop
      vertex 0.0 0.0 1.0
      vertex 10.0 0.0 1.0
      vertex 0.0 10.0 1.0
    endloop
  endfacet
  facet normal 0.0 0.0 1.0
    outer loop
      vertex 10.0 0.0 1.0
      vertex 10.0 10.0 1.0
      vertex 0.0 10.0 1.0
    endloop
  endfacet
endsolid test_triangle
"""
        with open(filepath, "w") as f:
            f.write(content)

    def _create_synthetic_binary_stl(self, filepath: Path):
        num_triangles = 2
        header = b"Binary STL Synthetic Test Header" + b" " * (80 - len("Binary STL Synthetic Test Header"))
        count = struct.pack("<I", num_triangles)

        # Triangle 1
        t1 = struct.pack(
            "<3f 3f 3f 3f H",
            0.0, 0.0, 1.0,  # normal
            0.0, 0.0, 2.0,  # v0
            5.0, 0.0, 2.0,  # v1
            0.0, 5.0, 2.0,  # v2
            0,
        )
        # Triangle 2
        t2 = struct.pack(
            "<3f 3f 3f 3f H",
            0.0, 0.0, 1.0,  # normal
            5.0, 0.0, 2.0,  # v0
            5.0, 5.0, 2.0,  # v1
            0.0, 5.0, 2.0,  # v2
            0,
        )
        with open(filepath, "wb") as f:
            f.write(header + count + t1 + t2)

    def test_parse_ascii_stl(self):
        path = Path(self.temp_dir) / "test_ascii.stl"
        self._create_synthetic_ascii_stl(path)

        verts, normals = rstl.load_stl(path)
        self.assertEqual(verts.shape, (2, 3, 3))
        self.assertEqual(normals.shape, (2, 3))
        # Check first triangle vertices
        np.testing.assert_allclose(verts[0, 0], [0.0, 0.0, 1.0])
        np.testing.assert_allclose(verts[0, 1], [10.0, 0.0, 1.0])
        np.testing.assert_allclose(verts[0, 2], [0.0, 10.0, 1.0])

    def test_parse_binary_stl(self):
        path = Path(self.temp_dir) / "test_binary.stl"
        self._create_synthetic_binary_stl(path)

        verts, normals = rstl.load_stl(path)
        self.assertEqual(verts.shape, (2, 3, 3))
        self.assertEqual(normals.shape, (2, 3))
        np.testing.assert_allclose(verts[0, 0], [0.0, 0.0, 2.0])
        np.testing.assert_allclose(verts[0, 1], [5.0, 0.0, 2.0])
        np.testing.assert_allclose(verts[0, 2], [0.0, 5.0, 2.0])

    def test_corrupted_binary_stl_falls_back(self):
        path = Path(self.temp_dir) / "corrupt_binary.stl"
        # 84 bytes header with triangle count 1000, but no triangle data
        header = b"x" * 80 + struct.pack("<I", 1000)
        with open(path, "wb") as f:
            f.write(header)

        # Should fall back to ASCII parser, resulting in empty mesh rather than crashing
        verts, normals = rstl.load_stl(path)
        self.assertEqual(len(verts), 0)

    def test_nonexistent_file_raises(self):
        with self.assertRaises(FileNotFoundError):
            rstl.load_stl(Path(self.temp_dir) / "does_not_exist.stl")


class TestRenderTopDown(unittest.TestCase):
    def test_render_empty_mesh(self):
        verts = np.empty((0, 3, 3), dtype=np.float32)
        normals = np.empty((0, 3), dtype=np.float32)
        img = rstl.render_top_down_image(verts, normals, width=128, height=128, bg_color="white")
        self.assertEqual(img.size, (128, 128))
        # All pixels should be white
        pixels = np.array(img)
        self.assertTrue((pixels[:, :, :3] == 255).all())

    def test_render_single_triangle(self):
        verts = np.array([[[0.0, 0.0, 0.0], [10.0, 0.0, 0.0], [0.0, 10.0, 0.0]]], dtype=np.float32)
        normals = np.array([[0.0, 0.0, 1.0]], dtype=np.float32)
        img = rstl.render_top_down_image(
            verts,
            normals,
            width=256,
            height=256,
            bg_color="transparent",
            supersample=1,
        )
        self.assertEqual(img.size, (256, 256))
        # Ensure there is rendered geometry (alpha > 0)
        alpha = np.array(img)[:, :, 3]
        self.assertTrue(np.any(alpha > 0))
        # Ensure background around borders is still transparent
        self.assertEqual(alpha[0, 0], 0)
        self.assertEqual(alpha[0, 255], 0)
        self.assertEqual(alpha[255, 0], 0)
        self.assertEqual(alpha[255, 255], 0)

    def test_aspect_ratio_preservation(self):
        # Very wide rectangle: 100 x 10
        v0 = np.array([0.0, 0.0, 0.0])
        v1 = np.array([100.0, 0.0, 0.0])
        v2 = np.array([100.0, 10.0, 0.0])
        v3 = np.array([0.0, 10.0, 0.0])
        triangles = np.array([[v0, v1, v2], [v0, v2, v3]], dtype=np.float32)
        normals = np.array([[0.0, 0.0, 1.0], [0.0, 0.0, 1.0]], dtype=np.float32)

        img = rstl.render_top_down_image(triangles, normals, width=200, height=200, bg_color="transparent", supersample=1)
        alpha = np.array(img)[:, :, 3]

        # Calculate bounding box of rendered non-transparent pixels
        y_indices, x_indices = np.where(alpha > 0)
        rendered_w = x_indices.max() - x_indices.min()
        rendered_h = y_indices.max() - y_indices.min()

        aspect_ratio = rendered_w / max(1, rendered_h)
        # Should be roughly 10:1 aspect ratio
        self.assertAlmostEqual(aspect_ratio, 10.0, delta=1.5)


class TestPreviewGeneration(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.mkdtemp()
        self.stl_path = Path(self.temp_dir) / "test_model.stl"

        # Write a small pyramid STL
        content = """solid pyramid
facet normal 0 0 -1
  outer loop
    vertex 0 0 0
    vertex 10 0 0
    vertex 10 10 0
  endloop
endfacet
facet normal 0 0 -1
  outer loop
    vertex 0 0 0
    vertex 10 10 0
    vertex 0 10 0
  endloop
endfacet
facet normal -1 0 1
  outer loop
    vertex 0 0 0
    vertex 0 10 0
    vertex 5 5 5
  endloop
endfacet
facet normal 1 0 1
  outer loop
    vertex 10 0 0
    vertex 5 5 5
    vertex 10 10 0
  endloop
endfacet
facet normal 0 -1 1
  outer loop
    vertex 0 0 0
    vertex 5 5 5
    vertex 10 0 0
  endloop
endfacet
facet normal 0 1 1
  outer loop
    vertex 0 10 0
    vertex 10 10 0
    vertex 5 5 5
  endloop
endfacet
endsolid pyramid
"""
        with open(self.stl_path, "w") as f:
            f.write(content)

    def tearDown(self):
        shutil.rmtree(self.temp_dir, ignore_errors=True)

    def test_generate_preview_default_output(self):
        out = rstl.generate_preview(self.stl_path, width=128, height=128)
        self.assertTrue(out.is_file())
        self.assertEqual(out.name, "test_model.png")

        with Image.open(out) as img:
            self.assertEqual(img.size, (128, 128))
            self.assertEqual(img.format, "PNG")

    def test_generate_preview_custom_output(self):
        custom_out = Path(self.temp_dir) / "custom_dir" / "custom_preview.png"
        out = rstl.generate_preview(self.stl_path, output_path=custom_out, width=64, height=64)
        self.assertEqual(out, custom_out)
        self.assertTrue(custom_out.is_file())

        with Image.open(custom_out) as img:
            self.assertEqual(img.size, (64, 64))

    def test_process_directory(self):
        # Add a second STL file
        second_stl = Path(self.temp_dir) / "second_model.STL"
        shutil.copy(self.stl_path, second_stl)

        generated = rstl.process_directory(
            directory=self.temp_dir,
            width=64,
            height=64,
            quiet=True,
        )
        self.assertEqual(len(generated), 2)
        for p in generated:
            self.assertTrue(p.is_file())
            self.assertEqual(p.suffix, ".png")


class TestCLI(unittest.TestCase):
    def test_cli_help(self):
        import subprocess
        result = subprocess.run(
            ["python3", "render_stl_preview.py", "--help"],
            capture_output=True,
            text=True,
        )
        self.assertEqual(result.returncode, 0)
        self.assertIn("Generate top-down PNG previews", result.stdout)

    def test_cli_execution_on_directory(self):
        import subprocess
        with tempfile.TemporaryDirectory() as tmp_dir:
            # Copy a small stl to tmp_dir
            workspace_dir = Path(__file__).resolve().parent.parent
            d27_src = workspace_dir / "D27.stl"
            shutil.copy(d27_src, Path(tmp_dir) / "D27.stl")

            result = subprocess.run(
                ["python3", "render_stl_preview.py", tmp_dir, "--size", "128", "-q"],
                capture_output=True,
                text=True,
            )
            self.assertEqual(result.returncode, 0)
            expected_png = Path(tmp_dir) / "D27.png"
            self.assertTrue(expected_png.is_file())
            with Image.open(expected_png) as img:
                self.assertEqual(img.size, (128, 128))


class TestIntegrationRealFiles(unittest.TestCase):
    def test_render_real_files(self):
        # Test rendering real files from the workspace
        workspace_dir = Path(__file__).resolve().parent.parent
        anx_path = workspace_dir / "anx.STL"
        d27_path = workspace_dir / "D27.stl"

        self.assertTrue(anx_path.is_file(), f"Expected {anx_path} to exist")
        self.assertTrue(d27_path.is_file(), f"Expected {d27_path} to exist")

        with tempfile.TemporaryDirectory() as tmp_dir:
            out_anx = Path(tmp_dir) / "anx.png"
            rstl.generate_preview(anx_path, output_path=out_anx, width=256, height=256)
            self.assertTrue(out_anx.is_file())
            with Image.open(out_anx) as img:
                self.assertEqual(img.size, (256, 256))
                arr = np.array(img)
                # Ensure object is rendered
                self.assertTrue(np.any(arr[:, :, 3] > 0))

            out_d27 = Path(tmp_dir) / "d27.png"
            rstl.generate_preview(d27_path, output_path=out_d27, width=256, height=256)
            self.assertTrue(out_d27.is_file())
            with Image.open(out_d27) as img:
                self.assertEqual(img.size, (256, 256))
                arr = np.array(img)
                self.assertTrue(np.any(arr[:, :, 3] > 0))


if __name__ == "__main__":
    unittest.main()
