
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.context.ColorHandlingContext;
import eu.printingin3d.javascad.context.IColorGenerationContext;
import eu.printingin3d.javascad.models.IModel;
import eu.printingin3d.javascad.utils.IScadFile;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.onebeartoe.modeling.javascad.statements.Use;

/**
 * @author Roberto Marquez
 */
public class OpenScadFile implements IScadFile
{    
    protected List<IModel> models;
    
    public List<Use> useStatements;

    public List<ModuleDefinition> moduleDifinitions;
    
    public OpenScadFile()
    {
        useStatements = new ArrayList();
        
        models = new ArrayList();
        
        moduleDifinitions = new ArrayList();
    }

    public void addModel(IModel model)
    {        
        models.add(model);   
    }
    
    @Override
    public File getFile(File root)
    {
        // TODO: Is this the right class to extend?
        return null; //????????
    }

    @Override
    public Collection<IModel> getModels()
    {
        return models;
    }

    @Override
    public IColorGenerationContext getContext()
    {
        return ColorHandlingContext.DEFAULT;
    }    
}
