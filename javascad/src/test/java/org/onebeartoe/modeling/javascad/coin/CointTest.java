
package org.onebeartoe.modeling.javascad.coin;

import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.tranzitions.Colorize;
import java.awt.Color;
import java.io.File;
import org.onebeartoe.modeling.javascad.JavaScadTest;
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
          
        Coin coin = new Coin();
        
        Abstract3dModel model = new Colorize(Color.pink, coin);
  
        OpenScadFile osf = new OpenScadFile();
        osf.useStatements.add(marioLibrary);
        osf.addModel(model);
        
        return osf;
    }
}
