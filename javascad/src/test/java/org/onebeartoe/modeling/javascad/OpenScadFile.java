/*
 */
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
 *
 * @author Roberto Marquez
 */
public class OpenScadFile implements IScadFile
{
//    public List<String> useStatements;
    
    protected List<IModel> models;
    
    public List<Use> useStatements;

    public List<ModuleDefinition> moduleDifinitions;
    
    public OpenScadFile()
    {
        useStatements = new ArrayList();
        
        models = new ArrayList();
        
        moduleDifinitions = new ArrayList();
    }

    public void addModel(
//                           OpenScadFile
                         IModel 
                                 model)
    {
        // TODO: are there even ever more than model????
//        for(IModel m : model.models)
        {
            models.add(model);
        }
    }
    
    @Override
    public File getFile(File root)
    {
//        throw new OperationNotSupportedException();
        
//        return root; //?????????
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
