
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.context.IColorGenerationContext;
import eu.printingin3d.javascad.models.Complex3dModel;
import eu.printingin3d.javascad.models.IModel;

/**
 * @author Roberto Marquez
 */
public class ModuleDefinition //extends Complex3dModel
{
    public String name;
    
    public IModel model;
    
    public ModuleDefinition(String name, IModel model)
    {
        this.name = name;
        this.model = model;
    }
    
    @Override
    public String toString()
    {
        IColorGenerationContext context = null;
        String moduleImplementation = model.toScad(context)
                                            .getScad();
        
        String s = System.lineSeparator() 
                    + "module "
                    + name
                    + "()"
                    + System.lineSeparator()
                    + "{"
                    + System.lineSeparator()
                    + moduleImplementation
                    + System.lineSeparator()
                    + "}"
                    + System.lineSeparator();
        
        return s;
    }
}
