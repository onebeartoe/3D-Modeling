
package org.onebeartoe.modeling.javascad.basics;

import eu.printingin3d.javascad.models.Abstract3dModel;
import java.io.File;
import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.ModuleCall;
import org.onebeartoe.modeling.javascad.OpenScadFile;
import org.onebeartoe.modeling.javascad.statements.Use;

/**
 * @author Roberto Marquez
 */
public class ModuleCallTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile()
    {
        File d = new File(".");
        String pwd  = d.getAbsolutePath();
        String message = "pwd: " + pwd;
        System.out.println(message);
        
        Use marioLibrary = new Use("../../../../../../../../../openscad/models/src/main/openscad/external-resources/plumber-brother/m/mario.scad");
        
        ModuleCall mc = new ModuleCall("marioThumbnail");               
        
        Abstract3dModel model = mc;
  
        OpenScadFile osf = new OpenScadFile();
        osf.useStatements.add(marioLibrary);
        osf.addModel(model);
        
        return osf;
    }
}
