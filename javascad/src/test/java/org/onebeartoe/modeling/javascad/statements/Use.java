
package org.onebeartoe.modeling.javascad.statements;

import eu.printingin3d.javascad.context.IColorGenerationContext;
import eu.printingin3d.javascad.models.SCAD;

/**
 * @author Roberto Marquez
 */
public class Use 
        //extends Complex3dModel
{
    public String openScadPath;
    
    public Use(String openScadPath)
    {
        this.openScadPath = openScadPath;
    }
    
    public String toString()
    {
        return innerToScad(null).getScad();
    }
    
//    @Override
    protected SCAD innerToScad(IColorGenerationContext context) 
    {
        SCAD result = new SCAD("use <");
        
        result = result.append(openScadPath).append(">");
        
        return result.append("\n");
    }    

    
}
