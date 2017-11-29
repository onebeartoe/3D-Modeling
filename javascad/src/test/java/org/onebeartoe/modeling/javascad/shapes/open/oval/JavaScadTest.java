
package org.onebeartoe.modeling.javascad.shapes.open.oval;

import eu.printingin3d.javascad.models.IModel;
import eu.printingin3d.javascad.utils.SaveScadFiles;
import java.io.File;
import java.io.IOException;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class JavaScadTest 
{
    protected String outputPath = "target/outscad/";
    
    protected void saveScadFile(File outDir, String outfileName, IModel model) throws IOException
    {
        SaveScadFiles ssf = new SaveScadFiles(outDir);
        ssf.addModel(outfileName, model);
        ssf.saveScadFiles();
    }
}
