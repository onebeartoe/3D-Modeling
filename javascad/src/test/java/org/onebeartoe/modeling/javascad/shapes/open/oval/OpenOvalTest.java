
package org.onebeartoe.modeling.javascad.shapes.open.oval;

import eu.printingin3d.javascad.models.Abstract3dModel;
import org.onebeartoe.modeling.javascad.JavaScadTest;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class OpenOvalTest extends JavaScadTest
{    
    @Override
    protected Abstract3dModel getModel()
    {
        int borderThickness = 1;
        double depth = 2;
        Abstract3dModel model = new OpenOval(borderThickness, depth);
        
        return model;
    }

    @Override
    protected String getOutfileName()
    {
        return "open-oval.scad";
    }
}
