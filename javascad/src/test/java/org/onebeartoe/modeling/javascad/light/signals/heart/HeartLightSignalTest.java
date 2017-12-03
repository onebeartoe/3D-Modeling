
package org.onebeartoe.modeling.javascad.light.signals.heart;

import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.OpenScadFile;
import org.onebeartoe.modeling.javascad.statements.Use;

/**
 * @author Roberto Marquez
 */
public class HeartLightSignalTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile() 
    {
        OpenScadFile model = new HeartLightSignal();
        Use heartLib        = new Use("../../../../../../../../../../../openscad/models/src/main/openscad/shapes/heart/heart.scad");
        Use openCylinderLib = new Use("../../../../../../../../../../../openscad/models/src/main/openscad/shapes/open-cylinder/open-cylinder.scad");        
        
        model.useStatements.add(heartLib);
        model.useStatements.add(openCylinderLib);
        
        return model;
    }
}
