
package org.onebeartoe.modeling.javascad.shapes.triangle;

import eu.printingin3d.javascad.models.Cylinder;
import eu.printingin3d.javascad.models.Extendable3dModel;

/**
 * @author Roberto Marquez
 */
public class Triangle extends Extendable3dModel
{
    /**
     * OpenSCAD equivalent:
     * 
     *  cylinder(r=20, h = 60, $fn=3); 
     */
    public Triangle(double zLength, double radius)
    {
        Cylinder triangle = new FacetedCylinder(zLength, radius, 3);
        
        baseModel = triangle;
    }
}
