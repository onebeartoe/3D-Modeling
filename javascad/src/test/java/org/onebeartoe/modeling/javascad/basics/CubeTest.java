
package org.onebeartoe.modeling.javascad.basics;

import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Cube;
import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.OpenScadFile;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class CubeTest extends JavaScadTest
{
    @Override
    protected OpenScadFile
            //Abstract3dModel
         getModelFile()
    {
        Abstract3dModel model = new Cube(50);
        
        OpenScadFile osf = new OpenScadFile();
        osf.addModel(model);
        
        return osf;
    }

    @Override
    protected String getOutfileName()
    {
        return "cube.scad";
    }
}
