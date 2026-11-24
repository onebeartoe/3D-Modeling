package com.thumbnailer.model;

import java.util.Collections;
import java.util.List;

/**
 * Immutable default implementation of {@link MeshModel} backed by a triangle list and precomputed bounds.
 */
public class DefaultMeshModel implements MeshModel {

    private final List<Triangle> triangles;
    private final BoundingBox bounds;

    public DefaultMeshModel(List<Triangle> triangles) {
        this.triangles = triangles == null ? List.of() : Collections.unmodifiableList(triangles);
        this.bounds = calculateBounds(this.triangles);
    }

    private static BoundingBox calculateBounds(List<Triangle> triangles) {
        if (triangles.isEmpty()) {
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

    @Override
    public List<Triangle> getTriangles() {
        return triangles;
    }

    @Override
    public BoundingBox getBounds() {
        return bounds;
    }
}
