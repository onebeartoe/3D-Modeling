
package org.onebeartoe.modeling.javascad.shapes.triangle;

import eu.printingin3d.javascad.models.Abstract3dModel;
import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.OpenScadFile;

/**
 * @author Roberto Marquez
 */
public class TriangleTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile()
    {
        Abstract3dModel triangle = new Triangle(3, 5);
        
        OpenScadFile osf = new OpenScadFile();
        osf.addModel(triangle);
        
        return osf;
    }

    @Override
    protected String getOutfileName()
    {
        return "triangle.scad";
    } 
}
