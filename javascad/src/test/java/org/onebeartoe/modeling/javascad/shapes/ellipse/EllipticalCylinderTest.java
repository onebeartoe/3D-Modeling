
package org.onebeartoe.modeling.javascad.shapes.ellipse;

import eu.printingin3d.javascad.models.Extendable3dModel;
import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.OpenScadFile;

/**
 * @author Roberto Marquez
 */
public class EllipticalCylinderTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile()
    {
        int zLength = 2;
        int w = 3;
        int h = 7;
        EllipticalCylinder ec = new EllipticalCylinder(w,h, zLength);
        
        OpenScadFile osf = new OpenScadFile();
        osf.addModel(ec);
        
        return osf;
    }

    @Override
    protected String getOutfileName()
    {
        return "elliptical.cylinder.scad";
    }    
}
