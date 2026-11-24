package com.thumbnailer.model;

import java.util.List;

/**
 * Common representation of a 3D triangle mesh model ready for rendering.
 */
public interface MeshModel {

    List<Triangle> getTriangles();

    BoundingBox getBounds();

    default int getTriangleCount() {
        return getTriangles().size();
    }

    static MeshModel of(List<Triangle> triangles) {
        return new DefaultMeshModel(triangles);
    }
}
