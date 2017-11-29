/*
 */
package org.onebeartoe.modeling.javascad.shapes.triangle;

import eu.printingin3d.javascad.models.Abstract3dModel;
import org.onebeartoe.modeling.javascad.JavaScadTest;

/**
 *
 * @author Roberto Marquez
 */
public class TriangleTest extends JavaScadTest
{

    @Override
    protected Abstract3dModel getModel()
    {
        Abstract3dModel triangle = new Triangle(3, 5);
        
        return triangle;
    }

    @Override
    protected String getOutfileName()
    {
        return "triangle.scad";
    }
    
}
