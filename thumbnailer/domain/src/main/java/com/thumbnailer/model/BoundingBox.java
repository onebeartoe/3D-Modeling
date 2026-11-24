package com.thumbnailer.model;

/**
 * Axis-aligned bounding box for a 3D model.
 */
public record BoundingBox(
        double minX, double maxX,
        double minY, double maxY,
        double minZ, double maxZ
) {

    public static BoundingBox empty() {
        return new BoundingBox(0, 0, 0, 0, 0, 0);
    }

    public double getSpanX() {
        return maxX - minX;
    }

    public double getSpanY() {
        return maxY - minY;
    }

    public double getSpanZ() {
        return maxZ - minZ;
    }

    public double getCenterX() {
        return (minX + maxX) / 2.0;
    }

    public double getCenterY() {
        return (minY + maxY) / 2.0;
    }

    public double getCenterZ() {
        return (minZ + maxZ) / 2.0;
    }
}
