
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;
import org.onebeartoe.application.logging.SysoutLoggerFactory;
import org.onebeartoe.modeling.openscad.test.suite.model.GlobalVariables;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCameraDirections;

/**
 * This class is used to verify that a corresponding baseline .png file exists,
 * for each .scad file.
 * 
 * @author Roberto Marquez
 */
public class DataSetValidator
{
    private Logger logger = SysoutLoggerFactory.getLogger("DataSetValidator");
    
    private static String baselineNameFor(Path scadFile, OpenScadCameraDirections direction)
    {
        // remove the '.oscad' from the file name
        String baseName = DataSetValidator.baseNameFor(scadFile);

        // concatinate '.png' to the base name
        String outfileName = baseName + "-" + direction + GlobalVariables.BASELINE_SUFFIX;

        outfileName = outfileName.replace("\\", "/");

        if (outfileName.startsWith("./"))
        {
            //            outfileName = outfileName.substring(2);
        }

        return outfileName;
    }
    
    public static String baselineNameFor(Path oscadInputFile, boolean forceGeneration, OpenScadCameraDirections direction)
    {
	String outfileName;
	
        if(forceGeneration)
        {
            outfileName = proposedBaselineNameFor(oscadInputFile, direction);
        }
        else
        {
            outfileName = baselineNameFor(oscadInputFile, direction);
        }
	
	return outfileName;
    }    

    private static String baseNameFor(Path scadFile)
    {
        String baseName = scadFile.toString();
        baseName = baseName.substring(0, baseName.length() - 5);

        return baseName;
    }
    
    private List<String> missingBaselineFiles(List<String> expectedBaselineFiles)
    {
        List<String> missingFiles = new ArrayList();
        
        for(String ebf : expectedBaselineFiles)
        
        {
            File f = new File(ebf);

            if( !f.exists() )
            {
                missingFiles.add(ebf);
            }
        }
        
        if(missingFiles.size() > 0)
        {
            logger.severe("Input files are missing:\n");
            
            missingFiles.forEach(mf -> { logger.severe(mf + "\n"); });            
        }
        
        return missingFiles;
    }    
    
    private static String proposedBaselineNameFor(Path scadFile, OpenScadCameraDirections direction)
    {
	String name = baselineNameFor(scadFile, direction);
	
	String replace = "-proposed" + GlobalVariables.BASELINE_SUFFIX;
	
	name = name.replace(GlobalVariables.BASELINE_SUFFIX, replace);
	
	return name;
    }
    
    private List<String> validateBody(Path path, OpenScadCameraDirections direction)
    {
        List<String> expectedBaselineFiles = new ArrayList();
        String pngPath = baselineNameFor(path, direction);
        expectedBaselineFiles.add(pngPath);
        
        return expectedBaselineFiles;
    }

    /**
     * The data set is valid if and only if the returned list is empty.
     * 
     * @param oscadFiles
     * @return a list of any missing .pngs
     */
    public List<String> validate(List<Path> oscadFiles) //throws Exception
    {
        final List<String> expectedBaselineFiles = new ArrayList();

    	oscadFiles
                //.parallelStream()
                .forEach((Path path) -> 
        {
//            System.out.println("parallel");
            List<OpenScadCameraDirections> list = Arrays.asList( OpenScadCameraDirections.values() );
            list
                .forEach( direction ->
            {
                List<String> validated = validateBody(path, direction);
                expectedBaselineFiles.addAll( validated );
            });
        });
        
        

        List<String> missingBaselineFiles = missingBaselineFiles(expectedBaselineFiles);       
       
        return missingBaselineFiles;
    }
}
