
package org.onebeartoe.modeling.javascad.shapes.ellipse;

import eu.printingin3d.javascad.models.Extendable3dModel;
import org.onebeartoe.modeling.javascad.JavaScadTest;

/**
 * @author Roberto Marquez
 */
public class EllipticalCylinderTest extends JavaScadTest
{
    @Override
    protected Extendable3dModel getModel()
    {
        int zLength = 2;
        int w = 3;
        int h = 7;
        EllipticalCylinder ec = new EllipticalCylinder(w,h, zLength);
        
        return ec;
    }

    @Override
    protected String getOutfileName()
    {
        return "elliptical.cylinder.scad";
    }    
}
