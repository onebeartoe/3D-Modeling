package com.thumbnailer.renderer;

import com.thumbnailer.model.BoundingBox;
import com.thumbnailer.model.MeshModel;
import com.thumbnailer.model.Triangle;
import com.thumbnailer.model.Vector3;

import javax.imageio.ImageIO;
import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;

/**
 * High-quality software renderer for top-down orthographic previews of 3D triangle meshes.
 * Includes Z-buffering, directional Blinn-Phong lighting, and 2x Super-Sample Anti-Aliasing (SSAA).
 */
public class TopDownModelRenderer {

    private final int outputWidth;
    private final int outputHeight;
    private final double marginRatio;
    private final Color modelColor;
    private final Color backgroundColor;
    private final boolean antiAliasing;

    /**
     * Default configuration: 800x800, sleek slate-blue model, crisp neutral background, SSAA enabled.
     */
    public TopDownModelRenderer() {
        this(800, 800, 0.08, new Color(37, 99, 235), new Color(248, 250, 252), true);
    }

    public TopDownModelRenderer(int width, int height, double marginRatio, Color modelColor, Color backgroundColor, boolean antiAliasing) {
        this.outputWidth = Math.max(64, width);
        this.outputHeight = Math.max(64, height);
        this.marginRatio = Math.max(0.01, Math.min(0.40, marginRatio));
        this.modelColor = modelColor != null ? modelColor : new Color(37, 99, 235);
        this.backgroundColor = backgroundColor != null ? backgroundColor : new Color(248, 250, 252);
        this.antiAliasing = antiAliasing;
    }

    /**
     * Renders the given mesh model from a top-down camera angle and saves it to a PNG file.
     */
    public void renderToFile(MeshModel model, File outputFile) throws IOException {
        BufferedImage image = render(model);
        File parent = outputFile.getParentFile();
        if (parent != null && !parent.exists()) {
            parent.mkdirs();
        }
        ImageIO.write(image, "PNG", outputFile);
    }

    /**
     * Renders the given mesh model from a top-down camera angle into a BufferedImage.
     */
    public BufferedImage render(MeshModel model) {
        int scaleMultiplier = antiAliasing ? 2 : 1;
        int renderW = outputWidth * scaleMultiplier;
        int renderH = outputHeight * scaleMultiplier;

        float[] zBuffer = new float[renderW * renderH];
        Arrays.fill(zBuffer, -Float.MAX_VALUE);

        int[] colorBuffer = new int[renderW * renderH];
        int bgRgb = backgroundColor.getRGB();
        Arrays.fill(colorBuffer, bgRgb);

        BoundingBox bounds = model.getBounds();
        double spanX = Math.max(bounds.getSpanX(), 1e-4);
        double spanY = Math.max(bounds.getSpanY(), 1e-4);
        double centerX = bounds.getCenterX();
        double centerY = bounds.getCenterY();

        double availW = renderW * (1.0 - 2.0 * marginRatio);
        double availH = renderH * (1.0 - 2.0 * marginRatio);
        double scale = Math.min(availW / spanX, availH / spanY);

        Vector3 keyLight = new Vector3(-0.4, -0.4, 0.82).normalize();
        Vector3 fillLight = new Vector3(0.4, 0.4, 0.6).normalize();
        Vector3 viewVec = new Vector3(0, 0, 1);
        Vector3 halfKey = keyLight.add(viewVec).normalize();

        for (Triangle triangle : model.getTriangles()) {
            Vector3 v1 = triangle.v1();
            Vector3 v2 = triangle.v2();
            Vector3 v3 = triangle.v3();

            // Transform to top-down screen coordinates (Z is depth, +Y in 3D is -Y in screen space)
            double x0 = (v1.x() - centerX) * scale + renderW / 2.0;
            double y0 = renderH / 2.0 - (v1.y() - centerY) * scale;
            double z0 = v1.z();

            double x1 = (v2.x() - centerX) * scale + renderW / 2.0;
            double y1 = renderH / 2.0 - (v2.y() - centerY) * scale;
            double z1 = v2.z();

            double x2 = (v3.x() - centerX) * scale + renderW / 2.0;
            double y2 = renderH / 2.0 - (v3.y() - centerY) * scale;
            double z2 = v3.z();

            double area = (x1 - x0) * (y2 - y0) - (y1 - y0) * (x2 - x0);
            if (Math.abs(area) < 1e-9) {
                continue;
            }

            // Ensure positive winding for consistent barycentric calculation
            if (area < 0) {
                double tx = x1; double ty = y1; double tz = z1;
                x1 = x2; y1 = y2; z1 = z2;
                x2 = tx; y2 = ty; z2 = tz;
                area = -area;
            }

            Vector3 normal = triangle.normal();
            if (normal == null || normal.lengthSquared() < 1e-6) {
                Vector3 e1 = v2.subtract(v1);
                Vector3 e2 = v3.subtract(v1);
                normal = e1.cross(e2).normalize();
            }
            if (normal.lengthSquared() < 1e-6) {
                normal = new Vector3(0, 0, 1);
            }
            // Two-sided lighting: flip normal if pointing away from camera
            if (normal.z() < 0) {
                normal = normal.negate();
            }

            double diff1 = Math.max(0.0, normal.dot(keyLight));
            double diff2 = Math.max(0.0, normal.dot(fillLight));
            double spec = Math.pow(Math.max(0.0, normal.dot(halfKey)), 16) * 0.25;
            double ambient = 0.35;

            double intensity = ambient + diff1 * 0.50 + diff2 * 0.20 + spec;
            intensity = Math.min(1.0, Math.max(0.0, intensity));

            Color facetColor = triangle.color() != null ? triangle.color() : modelColor;
            int r = Math.min(255, (int) (facetColor.getRed() * intensity));
            int g = Math.min(255, (int) (facetColor.getGreen() * intensity));
            int b = Math.min(255, (int) (facetColor.getBlue() * intensity));
            int pixelColor = (0xFF << 24) | (r << 16) | (g << 8) | b;

            int minPx = Math.max(0, (int) Math.floor(Math.min(x0, Math.min(x1, x2))));
            int maxPx = Math.min(renderW - 1, (int) Math.ceil(Math.max(x0, Math.max(x1, x2))));
            int minPy = Math.max(0, (int) Math.floor(Math.min(y0, Math.min(y1, y2))));
            int maxPy = Math.min(renderH - 1, (int) Math.ceil(Math.max(y0, Math.max(y1, y2))));

            double invArea = 1.0 / area;
            double eps = -1e-5;

            for (int py = minPy; py <= maxPy; py++) {
                double pY = py + 0.5;
                int rowOffset = py * renderW;
                for (int px = minPx; px <= maxPx; px++) {
                    double pX = px + 0.5;

                    double w0 = (x1 - pX) * (y2 - pY) - (y1 - pY) * (x2 - pX);
                    double w1 = (x2 - pX) * (y0 - pY) - (y2 - pY) * (x0 - pX);
                    double w2 = (x0 - pX) * (y1 - pY) - (y0 - pY) * (x1 - pX);

                    if (w0 >= eps && w1 >= eps && w2 >= eps) {
                        double nw0 = w0 * invArea;
                        double nw1 = w1 * invArea;
                        double nw2 = w2 * invArea;

                        float z = (float) (nw0 * z0 + nw1 * z1 + nw2 * z2);
                        int idx = rowOffset + px;

                        if (z > zBuffer[idx]) {
                            zBuffer[idx] = z;
                            colorBuffer[idx] = pixelColor;
                        }
                    }
                }
            }
        }

        BufferedImage finalImage = new BufferedImage(outputWidth, outputHeight, BufferedImage.TYPE_INT_ARGB);
        if (!antiAliasing) {
            finalImage.setRGB(0, 0, outputWidth, outputHeight, colorBuffer, 0, outputWidth);
        } else {
            downsample2x(finalImage, colorBuffer, renderW);
        }

        return finalImage;
    }

    private void downsample2x(BufferedImage finalImage, int[] colorBuffer, int renderW) {
        for (int y = 0; y < outputHeight; y++) {
            int srcY0 = y * 2;
            int srcY1 = srcY0 + 1;
            int offset0 = srcY0 * renderW;
            int offset1 = srcY1 * renderW;

            for (int x = 0; x < outputWidth; x++) {
                int srcX0 = x * 2;
                int srcX1 = srcX0 + 1;

                int c00 = colorBuffer[offset0 + srcX0];
                int c01 = colorBuffer[offset0 + srcX1];
                int c10 = colorBuffer[offset1 + srcX0];
                int c11 = colorBuffer[offset1 + srcX1];

                int a = ((c00 >>> 24) + (c01 >>> 24) + (c10 >>> 24) + (c11 >>> 24)) >> 2;
                int r = (((c00 >> 16) & 0xFF) + ((c01 >> 16) & 0xFF) + ((c10 >> 16) & 0xFF) + ((c11 >> 16) & 0xFF)) >> 2;
                int g = (((c00 >> 8) & 0xFF) + ((c01 >> 8) & 0xFF) + ((c10 >> 8) & 0xFF) + ((c11 >> 8) & 0xFF)) >> 2;
                int b = ((c00 & 0xFF) + (c01 & 0xFF) + (c10 & 0xFF) + (c11 & 0xFF)) >> 2;

                finalImage.setRGB(x, y, (a << 24) | (r << 16) | (g << 8) | b);
            }
        }
    }
}
