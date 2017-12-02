
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.coords.Dims3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Cube;
import eu.printingin3d.javascad.models.IModel;
import eu.printingin3d.javascad.tranzitions.Difference;
import java.io.File;
import java.io.IOException;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadTestSuiteTest;
import org.testng.annotations.Test;

/**
 *
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class UnanimousTest extends OpenScadTestSuiteTest
                            // extends JavaScadTest
{
    @Override
    protected String getRootTargetPath()
    {
        return "src/main/generated-openscad/";
    }
    
    protected String outputPath = "src/main/generated-openscad/";
    
    public UnanimousTest() throws Exception
    {
        
    }
    
    protected void saveScadFile(String outfileName, IModel model, int deleteme) throws IOException
    {
        String packageName = getClass().getPackage().getName().replace(".", "/");
        String path = outputPath + "/" + packageName;
        File outDir = new File(path);
  
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
    
    public Abstract3dModel getModel()
    {
        Dims3d blockDims = new Dims3d(4,4,4);
        Cube block = new Cube(blockDims);
        
        Dims3d cutoutDims = new Dims3d(5,5,5);
        Abstract3dModel cutoutCube = new Cube(cutoutDims)
                                .move( Coords3d.zOnly(-1) );
        
        Difference base = new Difference(block,
                                         cutoutCube);

        return base;
    }

    protected String getOutfileName()
    {
        return "unanimous.scad";
    }
    
    @Test()
    public void testSomething()
    {
        System.out.println("test something from " + getClass().getName());
    }    

    @Override
    public void willItWork()
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
