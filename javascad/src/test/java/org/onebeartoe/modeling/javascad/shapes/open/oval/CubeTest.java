
package org.onebeartoe.modeling.javascad.shapes.open.oval;

import eu.printingin3d.javascad.models.Cube;
import eu.printingin3d.javascad.models.IModel;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class CubeTest extends JavaScadTest
{
    @Override
    protected IModel getModel()
    {
        IModel model = new Cube(50);
        
        return model;
    }

    @Override
    protected String getOutfileName()
    {
        return "cube.scad";
    }
}
