
package org.onebeartoe.modeling.javascad.shapes.dialog.bubble;

import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.tranzitions.Colorize;
import java.awt.Color;
import org.onebeartoe.modeling.javascad.JavaScadTest;
import org.onebeartoe.modeling.javascad.OpenScadFile;

/**
 * @author Roberto Marquez
 */
public class DialogBubbleTest extends JavaScadTest
{
    @Override
    protected OpenScadFile getModelFile()
    {
        double zLength = 1;
        
        Abstract3dModel dialogBubble = new DialogBubble(zLength);
        
        Colorize c = new Colorize(Color.blue, dialogBubble);
        
        OpenScadFile osf = new OpenScadFile();
        osf.addModel(c);
        
        return osf;
    }

    @Override
    protected String getOutfileName()
    {
        return "dialog-bubble.scad";
    }
}
