
package org.onebeartoe.modeling.javascad.shapes.open.oval;

import eu.printingin3d.javascad.models.Cube;
import eu.printingin3d.javascad.models.IModel;
import java.io.File;
import java.io.IOException;
import org.testng.annotations.Test;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class OpenOvalTest extends JavaScadTest
{
    @Test()
    public void test() throws IOException
    {        
        IModel model = new Cube(50);

        File outDir = new File(outputPath);
        String outfileName = "oval.scad";
                
        saveScadFile(outDir, outfileName, model);
    }

    @Override
    protected IModel getModel()
    {
        IModel model = new Cube(50);
        
        return model;
    }

    @Override
    protected String getOutfileName()
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
