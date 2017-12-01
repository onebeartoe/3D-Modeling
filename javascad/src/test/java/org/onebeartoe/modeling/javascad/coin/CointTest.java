
package org.onebeartoe.modeling.javascad.coin;

import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Cylinder;
import eu.printingin3d.javascad.tranzitions.Difference;
import eu.printingin3d.javascad.tranzitions.Scale;
import java.io.File;
import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.ModuleCall;
import org.onebeartoe.modeling.javascad.OpenScadFile;
import org.onebeartoe.modeling.javascad.statements.Use;

/**
 * @author Roberto Marquez
 */
public class CointTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile()
    {
        File d = new File(".");
        String pwd  = d.getAbsolutePath();
        String message = "pwd: " + pwd;
        System.out.println(message);
        
        Use marioLibrary = new Use("../../../../../../../../../openscad/models/src/main/openscad/shapes/heart/heart.scad");
        
        ModuleCall heart = new ModuleCall("heartThumbnail");
                        
        Scale s = new Scale(heart.move(Coords3d.zOnly(-0.5))
                            , new Coords3d(1, 1, 1.02) );
        
        
        
        Cylinder coin = new Cylinder(1, 20);
        
        Difference diff = new Difference(coin, 
//                                            heart.move(Coords3d.zOnly(-0.5))
                                            s
        );
        
        Abstract3dModel model = diff;
  
        OpenScadFile osf = new OpenScadFile();
        osf.useStatements.add(marioLibrary);
        osf.addModel(model);
        
        return osf;
    }
}
