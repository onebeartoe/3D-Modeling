package org.onebeartoe.modeling.openscad.test.suite;

import java.io.File;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * This class is used to verify that a corresponding baseline .png file exists,
 * for each .scad file.
 * 
 * @author URHM020
 *
 */
public class DataSetValidator
{
    private static String baselineNameFor(Path scadFile, OpenScadCameraDirections direction)
    {
        // remove the '.oscad' from the file name
        String baseName = DataSetValidator.baseNameFor(scadFile);

        // concatinate '.png' to the base name
        String outfileName = baseName + "-java-" + direction + GlobalVariables.baselineSuffix;

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

    /**
     * The data set is valid if and only if the returned list is empty.
     * 
     * @param oscadFiles
     * @return a list of any missing .pngs
     */
    public List<String> validate(List<Path> oscadFiles)
    {
        List<String> expectedBaselineFiles = new ArrayList(); 
        	
    	oscadFiles.forEach((p) -> 
        {
            Stream.of(OpenScadCameraDirections.values() )
            		.forEach((v) -> 
    	    {
                String pngPath = baselineNameFor(p, v);

                expectedBaselineFiles.add(pngPath);
    	    });

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
