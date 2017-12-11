
package org.onebeartoe.modeling.javascad.light.signals.heart.of.hearts;

import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.OpenScadFile;
import org.onebeartoe.modeling.javascad.statements.Use;

/**
 * @author Roberto Marquez
 */
public class HeartOfHeartsLightSignalTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile() 
    {
        Use domeLib         = new Use("../../../../../../../../../../../../../openscad/models/src/main/openscad/shapes/dome/dome.scad");
        Use heartLib        = new Use("../../../../../../../../../../../../../openscad/models/src/main/openscad/shapes/heart/heart.scad");
        Use openCylinderLib = new Use("../../../../../../../../../../../../../openscad/models/src/main/openscad/shapes/open-cylinder/open-cylinder.scad");        
     
        OpenScadFile model = new HeartOfHeartsLightSignal();
        model.useStatements.add(domeLib);
        model.useStatements.add(heartLib);
        model.useStatements.add(openCylinderLib);
        
        return model;
    }
}
