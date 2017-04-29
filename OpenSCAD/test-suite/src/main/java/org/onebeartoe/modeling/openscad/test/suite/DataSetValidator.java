package org.onebeartoe.modeling.openscad.test.suite;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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
    
    private void printValidationResults(List<String> missingBaselineFiles)
    {
	System.out.println();
	
        if (missingBaselineFiles.isEmpty())
        {
            System.out.println("All input files are present.");
        }
        else
        {
            System.err.println("Some test suite input files are not present.");
            System.err.println("Try running '--generateBaselines' to generate the missing input files.");
        }
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
    public List<String> validate(List<Path> oscadFiles)
    {
        final List<String> expectedBaselineFiles = new ArrayList();
        	
    	oscadFiles.forEach((Path path) -> 
        {
            boolean parallel = false;
            
            if(parallel)
            {
                logger.log(Level.INFO, "the OpenSCAD files are processed in parallel.");
                List<OpenScadCameraDirections> list = Arrays.asList( OpenScadCameraDirections.values() );
                list.parallelStream()
                    .forEach( direction ->
                {
                    expectedBaselineFiles.addAll( validateBody(path, direction) );                       
                });
            }
            else
            {
                logger.log(Level.INFO, "\nThe OpenSCAD files are processed in sequentially.");
                Stream.of(OpenScadCameraDirections.values() )
                            .forEach((direction) -> 
                {
                    expectedBaselineFiles.addAll( validateBody(path, direction) );
                });                
            }
        });

        List<String> missingBaselineFiles = expectedBaselineFiles.stream().filter((ebf) -> 
        {
            File f = new File(ebf);

            boolean accepted = !f.exists();

            if (accepted)
            {
                System.err.println(" missing input file: " + ebf);
            }

            return accepted;
        }).collect(Collectors.toList());

        printValidationResults(missingBaselineFiles);

        return missingBaselineFiles;
    }
}
