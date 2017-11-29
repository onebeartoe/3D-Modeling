
package org.onebeartoe.modeling.javascad.shapes.cylinder;

import eu.printingin3d.javascad.basic.Radius;
import eu.printingin3d.javascad.models.Cylinder;
import eu.printingin3d.javascad.models.IModel;
import org.onebeartoe.modeling.javascad.shapes.open.oval.JavaScadTest;

/**
 * @author Roberto Marquez
 */
public class CylinderTest extends JavaScadTest
{

    @Override
    protected IModel getModel()
    {
        Cylinder c = new Cylinder(2, Radius.fromRadius(5));
        
        IModel model = c;
        
        return model;
    }

    @Override
    protected String getOutfileName()
    {
        return "cylinder.scad";
    }
    
}
