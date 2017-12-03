
package org.onebeartoe.modeling.javascad.light.signals;

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
// TODO: Move this to the LightSignal class.        
        Use batmanLib = new Use("../../../../../../../../../../openscad/models/src/main/openscad/external-resources/batman/batman.scad");
         
        OpenScadFile osf = new OpenScadFile();

        osf.useStatements.add(batmanLib);

        return osf;
    }
}
