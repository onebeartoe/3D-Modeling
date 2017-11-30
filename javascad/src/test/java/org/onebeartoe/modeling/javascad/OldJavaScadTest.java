
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.IModel;
import eu.printingin3d.javascad.utils.SaveScadFiles;
import java.io.File;
import java.io.IOException;
import org.testng.annotations.Test;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public abstract class OldJavaScadTest 
{
    protected String outputPath = "src/main/generated-openscad/";

    abstract protected 
Abstract3dModel                                                    
//                        Extendable3dModel
//                        IModel 
                                            getModel();
    
    abstract protected String getOutfileName();

    protected void saveScadFile(String outfileName, IModel model) throws IOException
    {
        File outDir = new File(outputPath);
        
        SaveScadFiles ssf = new SaveScadFiles(outDir);
        ssf.addModel(outfileName, model);
//        ssf.addModel
        ssf.saveScadFiles();
    }
    
    @Test()
    public void test() throws IOException
    {        
//        IModel 
//        Extendable3dModel
                Abstract3dModel
                model = getModel();
        
        String outfileName = getOutfileName();
                
        saveScadFile(outfileName, model);
    }    
}
