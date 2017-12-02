
package org.onebeartoe.modeling.javascad.light.signals.heart;

import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Cube;
import java.util.ArrayList;
import java.util.List;
import org.onebeartoe.modeling.javascad.OpenScadFile;
import org.onebeartoe.modeling.javascad.light.signals.LightSignal;
import org.onebeartoe.modeling.javascad.statements.Use;

/**
 * @author Roberto Marquez
 */
public class HeartLightSignal extends OpenScadFile
{
    public HeartLightSignal()
    {
        Use useLightSignal = new Use("../light-signal-test.scad");
        
        useStatements.add(useLightSignal);
                
        List<Abstract3dModel> baseCutouts = new ArrayList();                
        baseCutouts.add( new Cube(5) );
        
        LightSignal signal = new LightSignal(baseCutouts);
        
        models.add(signal);
    }
}
