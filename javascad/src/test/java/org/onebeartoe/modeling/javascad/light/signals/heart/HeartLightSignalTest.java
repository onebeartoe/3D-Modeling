
package org.onebeartoe.modeling.javascad.light.signals.heart;

import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.OpenScadFile;

/**
 * @author Roberto Marquez
 */
public class HeartLightSignalTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile() 
    {
        OpenScadFile model = new HeartLightSignal();
                
        return model;
    }
}
