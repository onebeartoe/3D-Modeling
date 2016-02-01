package org.onebeartoe.modeling.openscad.test.suite;

import java.io.File;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Collectors;

/**
 * This class is used to verify that a corresponding baseline .png file exists,
 * for each .scad file.
 * 
 * @author URHM020
 *
 */
public class DataSetValidator
{
    public static String baselineNameFor(Path scadFile, RenderViews direction)
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

    public static String baseNameFor(Path scadFile)
    {
        String baseName = scadFile.toString();
        baseName = baseName.substring(0, baseName.length() - 5);

        return baseName;
    }
    
    private void printValidationResults(List<String> missingBaselineFiles)
    {
        if (missingBaselineFiles.isEmpty())
        {
            System.out.println("All input files are present.");
        }
        else
        {
            System.err.println("The test suite detected that some input files are not present.");
        }
    }

    /**
     * The data set is valid if and only if the returned list is empty.
     * 
     * @param oscadFiles
     * @return a list of any missing .pngs
     */
    public List<String> validate(List<Path> oscadFiles)
    {
	
        List<String> expectedBaselineFiles = oscadFiles.stream().map((p) -> 
        {
            String pngPath = baselineNameFor(p, RenderViews.BOTTTOM);

            return pngPath;
        }).collect(Collectors.toList());

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
