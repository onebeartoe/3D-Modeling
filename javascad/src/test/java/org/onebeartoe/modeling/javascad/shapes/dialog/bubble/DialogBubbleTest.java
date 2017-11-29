
package org.onebeartoe.modeling.javascad.shapes.dialog.bubble;

import eu.printingin3d.javascad.models.Abstract3dModel;
import org.onebeartoe.modeling.javascad.JavaScadTest;

/**
 * @author Roberto Marquez
 */
public class DialogBubbleTest extends JavaScadTest
{

    @Override
    protected Abstract3dModel getModel()
    {
        double zLength = 1;
        
        Abstract3dModel dialogBubble = new DialogBubble(zLength);
        
        return dialogBubble;
    }

    @Override
    protected String getOutfileName()
    {
        return "dialog-bubble.scad";
    }
}
