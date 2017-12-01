
package org.onebeartoe.modeling.javascad;

import java.io.File;
import java.io.IOException;
import org.testng.annotations.Test;

/**
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public abstract class JavaScadTest 
{
    protected String outputPath = "src/main/generated-openscad/";

    public String classNameToDashFilename(String className)
    {
        StringBuilder s = new StringBuilder();
        className.chars().forEach(i -> 
        {
            char ch = (char) i;                                        

            if( Character.isUpperCase(ch) )
            {
                s.append("-");
            }

            s.append( Character.toLowerCase(ch) );
        });

        String dashName = s.toString().substring(1) + ".scad";
        
        return dashName;
    }
    
    // TODO: Rename this to getOpenScadFile()
    abstract protected OpenScadFile
//                       Abstract3dModel
                                       getModelFile();
    
    protected String getOutfileName()
    {
        String name = getClass().getSimpleName();
        
        name = classNameToDashFilename(name);
        
        return name;
    }

    protected void saveScadFile(String outfileName, 
                                                    OpenScadFile
//                                                    IModel 
                                                           model, int deleteme) throws IOException
    {
        String packageName = getClass().getPackage().getName().replace(".", "/");
        String path = outputPath + "/" + packageName;
        File outDir = new File(path);
  
        File outfile = new File(outDir, outfileName);
        
//        OpenScadFile scadFile = new OpenScadFile();
//        scadFile.addModel(model);
        
        SaveScadFileService ssfs = new SaveScadFileService();
        ssfs.saveModelAsScad(outfile, model);
    }
    
    @Test()
    public void test() throws IOException
    {
        OpenScadFile
//        Abstract3dModel 
                model = getModelFile();
        
        String outfileName = getOutfileName();
                
        saveScadFile(outfileName, model, 9);
    }    
}
