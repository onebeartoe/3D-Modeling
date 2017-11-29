
package org.onebeartoe.modeling.javascad.basics;

import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Cube;
import org.onebeartoe.modeling.javascad.JavaScadTest;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class CubeTest extends JavaScadTest
{
    @Override
    protected Abstract3dModel getModel()
    {
        Abstract3dModel model = new Cube(50);
        
        return model;
    }

    @Override
    protected String getOutfileName()
    {
        return "cube.scad";
    }
}
