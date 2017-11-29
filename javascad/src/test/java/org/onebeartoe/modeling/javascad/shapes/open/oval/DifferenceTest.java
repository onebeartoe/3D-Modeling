
package org.onebeartoe.modeling.javascad.shapes.open.oval;

import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.coords.Dims3d;
import eu.printingin3d.javascad.models.Cube;
import eu.printingin3d.javascad.models.IModel;
import eu.printingin3d.javascad.tranzitions.Difference;

/**
 *
 * @author Roberto Marquez - https://github.com/onebeartoe
 */
public class DifferenceTest extends JavaScadTest
{
    public IModel getModel()
    {
        Dims3d blockDims = new Dims3d(4,4,4);
        
        Dims3d cutoutDims = new Dims3d(5,5,5)
            ;
        
        Difference base = new Difference(
                                        new Cube(blockDims),
                
                                        new Cube(
                                                cutoutDims
                                                )
                .move(Coords3d.zOnly(-1) )
				);
        
//        base.
        
        
        return base;
    }

    @Override
    protected String getOutfileName()
    {
        return "difference.scad";
    }
}
