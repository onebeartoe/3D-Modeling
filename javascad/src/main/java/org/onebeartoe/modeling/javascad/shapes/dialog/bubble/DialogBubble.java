
package org.onebeartoe.modeling.javascad.shapes.dialog.bubble;

import eu.printingin3d.javascad.coords.Angles3d;
import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.models.Extendable3dModel;
import eu.printingin3d.javascad.tranzitions.Difference;
import eu.printingin3d.javascad.tranzitions.Union;
import org.onebeartoe.modeling.javascad.shapes.triangle.Triangle;
import org.onebeartoe.modeling.javascad.shapes.open.oval.OpenOval;

/**
 * @author Roberto Marquez
 */
public class DialogBubble extends Extendable3dModel
{
    public DialogBubble(double zLength)
    {        
        Union
//        Extendable3dModel
                block = block(zLength);
        
        Extendable3dModel cutout = cutout(zLength);
        
        Difference difference = new Difference(block
        //        , cutout
        );
        
        baseModel = difference;
    }
    
    private Union
//                 Extendable3dModel
         block(double zLength)
    {
        OpenOval bubble = new OpenOval(1, zLength);
        
        double sideLength = 3;
        Triangle pointer = new Triangle(zLength, sideLength);
        pointer.rotate(Angles3d.zOnly(45));
        pointer.move( new Coords3d(0, -3, 0) );
        
        Union block = new Union(bubble, pointer);
        
        
        
        return block;
    }
    
    private Extendable3dModel cutout(double height)
    {
        Triangle pointer = new Triangle(height, 5);
        
        return pointer;
    }    
}
