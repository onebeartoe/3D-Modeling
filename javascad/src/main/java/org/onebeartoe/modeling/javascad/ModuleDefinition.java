
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.context.ColorHandlingContext;
import eu.printingin3d.javascad.context.IColorGenerationContext;
import eu.printingin3d.javascad.models.IModel;

/**
 * @author Roberto Marquez
 */
public class ModuleDefinition
{
    public String name;
    
    public IModel model;
    
    public IColorGenerationContext context;
    
    public ModuleDefinition(String name, IModel model)
    {
        this.name = name;
        this.model = model;
        
        context = ColorHandlingContext.DEFAULT;
    }
    
    @Override
    public String toString()
    {
//        IColorGenerationContext context = model.get
//        w
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