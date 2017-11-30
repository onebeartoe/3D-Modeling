
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.IModel;
import java.io.File;
import java.io.IOException;
import org.testng.annotations.Test;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public abstract class JavaScadTest 
{
    protected String outputPath = "src/main/generated-openscad/";

    abstract protected Abstract3dModel getModel();
    
    abstract protected String getOutfileName();

    protected void saveScadFile(String outfileName, IModel model, int deleteme) throws IOException
    {
        File outDir = new File(outputPath);
  
        File outfile = new File(outDir, outfileName);
        
        OpenScadFile scadFile = new OpenScadFile();
        scadFile.addModel(model);
        
        SaveScadFileService ssfs = new SaveScadFileService();
        ssfs.saveModelAsScad(outfile, scadFile);
    }
    
    @Test()
    public void test() throws IOException
    {        
        Abstract3dModel model = getModel();
        
        String outfileName = getOutfileName();
                
        saveScadFile(outfileName, model, 9);
    }    
}
