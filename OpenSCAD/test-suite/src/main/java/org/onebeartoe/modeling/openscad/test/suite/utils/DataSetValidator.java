
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import org.onebeartoe.modeling.openscad.test.suite.GlobalVariables;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCameraDirections;

/**
 * This class is used to verify that a corresponding baseline .png file exists,
 * for each .scad file.
 * 
 * @author Roberto Marquez
 */
public class DataSetValidator
{
    private Logger logger = Logger.getLogger("DataSetValidator");
    
    private static String baselineNameFor(Path scadFile, OpenScadCameraDirections direction)
    {
        // remove the '.oscad' from the file name
        String baseName = DataSetValidator.baseNameFor(scadFile);

        // concatinate '.png' to the base name
        String outfileName = baseName + "-" + direction + GlobalVariables.baselineSuffix;

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
        List<String> missingFiles = expectedBaselineFiles.parallelStream()
            .filter( ebf ->
            {
                File f = new File(ebf);

                boolean accepted = !f.exists();

                return accepted;
            })
            .sorted()
            .collect(Collectors.toList());
        
        if(missingFiles.size() > 0)
        {
            System.err.println();
            System.err.println("missing input files:");
            missingFiles.forEach(mf -> {System.err.println(mf);});            
        }
        
        return missingFiles;
    }    
    
    private static String proposedBaselineNameFor(Path scadFile, OpenScadCameraDirections direction)
    {
	String name = baselineNameFor(scadFile, direction);
	
	String replace = "-proposed" + GlobalVariables.baselineSuffix;
	
	name = name.replace(GlobalVariables.baselineSuffix, replace);
	
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
    public List<String> validate(List<Path> oscadFiles) throws Exception
    {
        final List<String> expectedBaselineFiles = new ArrayList();

    	oscadFiles.parallelStream().forEach((Path path) -> 
        {
            List<OpenScadCameraDirections> list = Arrays.asList( OpenScadCameraDirections.values() );
            list.parallelStream()
                .forEach( direction ->
            {
                expectedBaselineFiles.addAll( validateBody(path, direction) );
            });
        });

        List<String> missingBaselineFiles = missingBaselineFiles(expectedBaselineFiles);       
       
        return missingBaselineFiles;
    }
}