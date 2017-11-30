
package org.onebeartoe.modeling.javascad.basics;

import eu.printingin3d.javascad.basic.Radius;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Cylinder;
import org.onebeartoe.modeling.javascad.JavaScadTest;

/**
 * @author Roberto Marquez
 */
public class CylinderTest extends JavaScadTest
{
    @Override
    protected Abstract3dModel getModel()
    {
        Cylinder c = new Cylinder(2, Radius.fromRadius(5));
        
        Abstract3dModel model = c;
        
        return model;
    }

    @Override
    protected String getOutfileName()
    {
        return "cylinder.scad";
    }
}
