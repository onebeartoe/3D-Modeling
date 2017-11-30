
package org.onebeartoe.modeling.javascad;

import eu.printingin3d.javascad.context.IColorGenerationContext;
import eu.printingin3d.javascad.models.IModel;
import eu.printingin3d.javascad.models.SCAD;
import eu.printingin3d.javascad.utils.IScadFile;
import eu.printingin3d.javascad.utils.ModelToFile;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.List;

/**
 * @author Roberto Marquez
 */
public class SaveScadFileService
{
//    private final List<IScadFile> scadFiles = new ArrayList<>();
    
    //TODO: Rename the File root paramater.
    public void saveModelAsScad(File root, OpenScadFile scadFile) throws IOException
    {
//        for (OpenScadFile scadFile : scadFiles) 
        {
            File file = root;
            file.getParentFile().mkdirs();

//            ModelToFile modelToFile = new ModelToFile(file);
//            
//            modelToFile.addModels(scadFile.getModels())
//                       .saveToFile(scadFile.getContext());
            
            saveToFile(file, scadFile);
        }        
    }
    
    private void saveToFile(File file, OpenScadFile scadFile) throws IOException
    {
        Writer writer = new FileWriter(file);
        try 
        {
            // write out any 'use' statements for this OpenSCAD file
            for(String u : scadFile.useStatements)
            {
                String line = "use <" + u + ">" + System.lineSeparator();
                
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
        finally 
        {
            writer.close();
        }        
    }
}
