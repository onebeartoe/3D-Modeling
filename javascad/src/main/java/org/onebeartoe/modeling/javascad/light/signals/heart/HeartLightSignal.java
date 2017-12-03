
package org.onebeartoe.modeling.javascad.light.signals.heart;

import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.tranzitions.Scale;
import java.util.ArrayList;
import java.util.List;
import org.onebeartoe.modeling.javascad.ModuleCall;
import org.onebeartoe.modeling.javascad.OpenScadFile;
import org.onebeartoe.modeling.javascad.light.signals.LightSignal;

/**
 * @author Roberto Marquez
 */
public class HeartLightSignal extends OpenScadFile
{
    public HeartLightSignal()
    {
        
        Abstract3dModel heartCall = new ModuleCall("heartThumbnail");
        heartCall = heartCall.move( new Coords3d(0, 0, -0.51) );
        Scale heartScale = new Scale(heartCall, new Coords3d(1, 1, 2.5));
        List<Abstract3dModel> baseCutouts = new ArrayList();                
        baseCutouts.add(heartScale);
        
        LightSignal signal = new LightSignal(baseCutouts);
        
        models.add(signal);
    }
}
