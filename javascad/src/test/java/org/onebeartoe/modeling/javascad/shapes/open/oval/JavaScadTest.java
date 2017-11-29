
package org.onebeartoe.modeling.javascad.shapes.open.oval;

import eu.printingin3d.javascad.models.IModel;
import eu.printingin3d.javascad.utils.SaveScadFiles;
import java.io.File;
import java.io.IOException;
import org.testng.annotations.Test;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public abstract class JavaScadTest 
{
    protected String outputPath = "target/outscad/";
    
    abstract protected IModel getModel();
    
    abstract protected String getOutfileName();

    protected void saveScadFile(File outDir, String outfileName, IModel model) throws IOException
    {
        SaveScadFiles ssf = new SaveScadFiles(outDir);
        ssf.addModel(outfileName, model);
        ssf.saveScadFiles();
    }
    
    @Test()
    public void test() throws IOException
    {        
        IModel model = getModel();

        File outDir = new File(outputPath);
        
        String outfileName = getOutfileName();
                
        saveScadFile(outDir, outfileName, model);
    }    
}
