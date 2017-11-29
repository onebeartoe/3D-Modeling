
package org.onebeartoe.modeling.javascad.basics;

import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.coords.Dims3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Cube;
import eu.printingin3d.javascad.tranzitions.Difference;
import org.onebeartoe.modeling.javascad.JavaScadTest;

/**
 *
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class DifferenceTest extends JavaScadTest
{
    @Override
    public 
            Abstract3dModel
            //Extendable3dModel 
        getModel()
    {
        Dims3d blockDims = new Dims3d(4,4,4);
        Cube block = new Cube(blockDims);
        
        Dims3d cutoutDims = new Dims3d(5,5,5);
        Abstract3dModel cutoutCube = new Cube(cutoutDims)
                                .move( Coords3d.zOnly(-1) );
        
        Difference base = new Difference(block,
                                         cutoutCube);

        return base;
    }

    @Override
    protected String getOutfileName()
    {
        return "difference.scad";
    }
}
