
package org.onebeartoe.modeling.javascad.shapes.triangle;

import eu.printingin3d.javascad.context.IColorGenerationContext;
import eu.printingin3d.javascad.exceptions.IllegalValueException;
import eu.printingin3d.javascad.models.Cylinder;
import eu.printingin3d.javascad.models.SCAD;
import eu.printingin3d.javascad.utils.DoubleUtils;

/**
 * @author Roberto Marquez
 */
public class FacetedCylinder extends Cylinder
{
    protected int fn = 0;
    
    public FacetedCylinder(double length, double r, int fn) throws IllegalValueException
    {
        super(length, r);
        
        this.fn = fn;
    }

    @Override
    protected SCAD innerToScad(IColorGenerationContext context) 
    {
        String fnConfig = "";
        if(fn != 0)
        {
            fnConfig = ", $fn = " + fn;
        }
        
        String radiusConfig;
        
        if (bottomRadius.equals(topRadius)) 
        {
            radiusConfig = ", r=" + bottomRadius;
        }
        else
        {
            radiusConfig = ", r1="+bottomRadius
                            + ", r2="+topRadius;
        }

        return new SCAD("cylinder(h="+DoubleUtils.formatDouble(length)+
                                radiusConfig
                                + fnConfig
                                +", center=true);\n");
    }
}
