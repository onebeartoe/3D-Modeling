
package org.onebeartoe.modeling.javascad.shapes.open.oval;

import eu.printingin3d.javascad.models.Cube;
import eu.printingin3d.javascad.models.IModel;
import eu.printingin3d.javascad.utils.SaveScadFiles;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.testng.annotations.Test;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class CubeTest extends JavaScadTest
{
    @Test()
    public void test() throws IOException
    {
        IModel model = new Cube(50);
        
        List<IModel> modelList = new ArrayList();
        modelList.add(model);

        File outDir = new File(outputPath);
        String outFilename = "cube.scad";
        
        new SaveScadFiles(outDir).
		addModel(outFilename, model).
		saveScadFiles();
    }
}
