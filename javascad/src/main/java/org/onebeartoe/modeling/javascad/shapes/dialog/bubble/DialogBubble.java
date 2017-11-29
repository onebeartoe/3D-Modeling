
package org.onebeartoe.modeling.javascad.shapes.dialog.bubble;

import eu.printingin3d.javascad.coords.Angles3d;
import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Complex3dModel;
import eu.printingin3d.javascad.models.Extendable3dModel;
import eu.printingin3d.javascad.tranzitions.Difference;
import eu.printingin3d.javascad.tranzitions.Translate;
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
        Complex3dModel
//        Union
//        Extendable3dModel
                block = block(zLength);
        
        Extendable3dModel cutout = cutout(zLength);
        
        Difference difference = new Difference(block
        //        , cutout
        );
        
        baseModel = difference;
    }
    
    private Complex3dModel
//                 Extendable3dModel
         block(double zLength)
    {
        OpenOval bubble = new OpenOval(1, zLength);
        
        double sideLength = 3;
        Abstract3dModel pointer = new Triangle(zLength, sideLength);
        
//        pointer.rotate(Angles3d.zOnly(45));
        Coords3d translateCoords = new Coords3d(6, -3, 0);
        
        pointer = pointer.rotate(Angles3d.zOnly(-10))        
                         .move(translateCoords);
                         
        
//        Translate translate = new Translate(pointer, translateCoords);
        
        Union block = new Union(bubble, pointer);
//        Union block = new Union(bubble, translate);
        
//        block.
        
        return block;
    }
    
    private Extendable3dModel cutout(double height)
    {
        Triangle pointer = new Triangle(height, 5);
        
        return pointer;
    }    
}
