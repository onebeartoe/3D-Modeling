package com.thumbnailer.model;

import java.util.List;

/**
 * Represents a complete 3D model parsed from an STL file.
 */
public class StlModel extends DefaultMeshModel {

    public StlModel(List<Triangle> triangles) {
        super(triangles);
    }
}
