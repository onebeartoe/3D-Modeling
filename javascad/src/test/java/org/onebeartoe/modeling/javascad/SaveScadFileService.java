
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.context.IColorGenerationContext;
import eu.printingin3d.javascad.models.IModel;
import eu.printingin3d.javascad.models.SCAD;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import org.onebeartoe.modeling.javascad.statements.Use;

// TODO: Rename this class to ScadFileService, or something better.
/**
 * @author Roberto Marquez
 */
public class SaveScadFileService
{    
    //TODO: Rename the File root paramater.
    public void saveModelAsScad(File root, OpenScadFile scadFile) throws IOException
    {
        File file = root;
        file.getParentFile().mkdirs();

        saveToFile(file, scadFile);
    }
    
    private void saveToFile(File file, OpenScadFile scadFile) throws IOException
    {
        try (Writer writer = new FileWriter(file)) 
        {
            // write out any 'use' statements for this OpenSCAD file
            for(Use u : scadFile.useStatements)
            {
                String line = u + System.lineSeparator();                
                
                writer.append(line);
            }
            
            for(ModuleDefinition md : scadFile.moduleDifinitions)
            {
                String line = md + System.lineSeparator();
                
                writer.append(line);
            }
            
            for (IModel model : scadFile.getModels()) 
            {
                IColorGenerationContext context = scadFile.getContext();
                SCAD scad = model.toScad(context);
                String s = scad.getScad();
                
                writer.append(s);
            }
        }        
    }
}
