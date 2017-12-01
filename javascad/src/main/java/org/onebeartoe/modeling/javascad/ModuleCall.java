/*
 */
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.context.IColorGenerationContext;
import eu.printingin3d.javascad.context.IScadGenerationContext;
import eu.printingin3d.javascad.coords.Boundaries3d;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Complex3dModel;
import eu.printingin3d.javascad.models.SCAD;
import eu.printingin3d.javascad.vrl.CSG;
import eu.printingin3d.javascad.vrl.FacetGenerationContext;

/**
 *
 * @author Roberto Marquez
 */
public class ModuleCall extends Complex3dModel
                                // Complex3dModel
                                // Abstract3dModel
{
    private final String moduleName;
    
    public ModuleCall(String moduleName)
    {
        this.moduleName = moduleName;
    }
    
    @Override
    protected SCAD innerToScad(IColorGenerationContext context) 
    {
        SCAD result = new SCAD(moduleName);
        
        result = result.append("(").append(")");
        
        return result.append(";");
    }

    @Override
    protected Abstract3dModel innerCloneModel()
    {
        ModuleCall mc = new ModuleCall(moduleName);
        
        return mc;
    }

    @Override
    protected Boundaries3d getModelBoundaries()
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected CSG toInnerCSG(FacetGenerationContext context)
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected Abstract3dModel innerSubModel(IScadGenerationContext context)
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
