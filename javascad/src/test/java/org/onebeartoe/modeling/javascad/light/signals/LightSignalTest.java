
package org.onebeartoe.modeling.javascad.light.signals;

import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.tranzitions.Colorize;
import java.awt.Color;
import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.OpenScadFile;
import org.onebeartoe.modeling.javascad.statements.Use;

/**
 * This is part of a recreation of the .scad file at
 * 
 *      3D-Modeling/openscad/models/src/main/openscad/signals/light-signals/light-signal.scad
 * 
 * @author Roberto Marquez
 */
public class LightSignalTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile()
    {
        Use marioLibrary = new Use("../../../../../../../../../../openscad/models/src/main/openscad/shapes/heart/heart.scad");
          
        LightSignal signal = new LightSignal();
        
        Abstract3dModel model = new Colorize(Color.MAGENTA, signal);
  
        OpenScadFile osf = new OpenScadFile();
        osf.useStatements.add(marioLibrary);
        osf.addModel(model);
        
        return osf;
    }
}
