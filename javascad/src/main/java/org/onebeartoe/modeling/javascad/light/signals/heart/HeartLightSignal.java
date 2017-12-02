
package org.onebeartoe.modeling.javascad.light.signals.heart;

import org.onebeartoe.modeling.javascad.ModuleCall;
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
        
        ModuleCall moduleCall = new ModuleCall(LightSignal.name);
        
        models.add(moduleCall);
    }
}
