
package org.onebeartoe.modeling.javascad.basics;

import eu.printingin3d.javascad.basic.Radius;
import eu.printingin3d.javascad.models.Cylinder;
import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.OpenScadFile;

/**
 * @author Roberto Marquez
 */
public class CylinderTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile()
    {
        Cylinder c = new Cylinder(2, Radius.fromRadius(5));
        
        OpenScadFile osf = new OpenScadFile();
        osf.addModel(c);
        
        return osf;
    }

    @Override
    protected String getOutfileName()
    {
        return "cylinder.scad";
    }
}
