package com.thumbnailer.model;

import java.awt.Color;

/**
 * Represents a single triangle facet in a 3D mesh, with an optional per-facet color.
 */
public record Triangle(Vector3 v1, Vector3 v2, Vector3 v3, Vector3 normal, Color color) {

    public Triangle {
        if (normal == null || normal.lengthSquared() < 1e-12) {
            Vector3 edge1 = v2.subtract(v1);
            Vector3 edge2 = v3.subtract(v1);
            normal = edge1.cross(edge2).normalize();
        }
    }

    public Triangle(Vector3 v1, Vector3 v2, Vector3 v3, Vector3 normal) {
        this(v1, v2, v3, normal, null);
    }

    public Triangle(Vector3 v1, Vector3 v2, Vector3 v3) {
        this(v1, v2, v3, null, null);
    }

    public Triangle(Vector3 v1, Vector3 v2, Vector3 v3, Color color) {
        this(v1, v2, v3, null, color);
    }
}
