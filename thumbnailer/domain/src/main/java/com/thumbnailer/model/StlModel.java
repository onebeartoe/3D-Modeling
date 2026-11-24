package com.thumbnailer.model;

import java.util.Collections;
import java.util.List;

/**
 * Represents a complete 3D model parsed from an STL file.
 */
public class StlModel {

    private final List<Triangle> triangles;
    private final BoundingBox bounds;

    public StlModel(List<Triangle> triangles) {
        this.triangles = Collections.unmodifiableList(triangles);
        this.bounds = calculateBounds(triangles);
    }

    private static BoundingBox calculateBounds(List<Triangle> triangles) {
        if (triangles == null || triangles.isEmpty()) {
            return BoundingBox.empty();
        }

        double minX = Double.POSITIVE_INFINITY;
        double maxX = Double.NEGATIVE_INFINITY;
        double minY = Double.POSITIVE_INFINITY;
        double maxY = Double.NEGATIVE_INFINITY;
        double minZ = Double.POSITIVE_INFINITY;
        double maxZ = Double.NEGATIVE_INFINITY;

        for (Triangle t : triangles) {
            Vector3[] vertices = {t.v1(), t.v2(), t.v3()};
            for (Vector3 v : vertices) {
                if (v.x() < minX) minX = v.x();
                if (v.x() > maxX) maxX = v.x();
                if (v.y() < minY) minY = v.y();
                if (v.y() > maxY) maxY = v.y();
                if (v.z() < minZ) minZ = v.z();
                if (v.z() > maxZ) maxZ = v.z();
            }
        }

        return new BoundingBox(minX, maxX, minY, maxY, minZ, maxZ);
    }

    public List<Triangle> getTriangles() {
        return triangles;
    }

    public BoundingBox getBounds() {
        return bounds;
    }

    public int getTriangleCount() {
        return triangles.size();
    }
}
