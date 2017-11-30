
package org.onebeartoe.modeling.javascad.shapes.dialog.bubble;

import eu.printingin3d.javascad.coords.Angles3d;
import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Complex3dModel;
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
        Angles3d pointerRotate = Angles3d.zOnly(-10);
        
        Complex3dModel block = block(zLength, pointerRotate);
        
        Abstract3dModel cutout = cutout(zLength, pointerRotate);
        
        Difference difference = new Difference(block, cutout);
        
        baseModel = difference;
    }
    
    private Complex3dModel block(double zLength, Angles3d pointerRotate)
    {
        OpenOval bubble = new OpenOval(1, zLength);
        
        Abstract3dModel pointer = pointer(zLength, pointerRotate);

        Union block = new Union(bubble, pointer);
        
        return block;
    }
    
    private Abstract3dModel cutout(double height, Angles3d pointerRotate)
    {
        Coords3d translateCoords = new Coords3d(-1.8, 0.3, -0.01);
        
        Abstract3dModel pointer = pointer(height+0.03, pointerRotate)
                                    .move(translateCoords);
        
        return pointer;
    }

    private Abstract3dModel pointer(double zLength, Angles3d pointerRotate)
    {
        double sideLength = 3;
        Coords3d translateCoords = new Coords3d(6, -3, 0);
        
        Abstract3dModel pointer = new Triangle(zLength, sideLength)
                                        .rotate(pointerRotate)        
                                        .move(translateCoords);

        return pointer;
    }
}
