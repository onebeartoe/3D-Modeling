
package org.onebeartoe.modeling.javascad.shapes.ellipse;

import eu.printingin3d.javascad.basic.Radius;
import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.models.Cylinder;
import eu.printingin3d.javascad.models.Extendable3dModel;
import eu.printingin3d.javascad.tranzitions.Scale;

/**
 * @author Roberto Marquez
 */
public class EllipticalCylinder extends Extendable3dModel
{
    public EllipticalCylinder()
    {
        this(5,10, 1);
    }
    
    /** This is from OpenSCD's MCAD/shapes.scad
     * 
        module ellipticalCylinder(w,h, height, center = false) 
        {
            scale([1, h/w, 1]) 
            cylinder(h=height, r=w, center=center);
        }
    */
    public EllipticalCylinder(int w, int h, double zLength)
    {
        Cylinder c = new Cylinder(zLength, Radius.fromRadius(w));
        
        Coords3d scaleValues = new Coords3d(1, h/w, 1);
        Scale scale = new Scale(c, scaleValues);
        
        baseModel = scale;
    }
}
