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
    /**
     * The data set is valid if and only if the returned list is empty.
     * 
     * @param oscadFiles
     * @return a list of any missing .pngs
     */
    public List<String> validate(List<Path> oscadFiles)
    {
        List<String> expectedBaselineFiles = oscadFiles.stream()
                    .map( (p) -> 
                    {
                        String pngPath = p.toString();
                        pngPath = pngPath.substring(0, pngPath.length()-5);
                        pngPath = pngPath + GlobalVariables.baselineSuffix;
                      
                        return pngPath;
                    })
                    .collect(Collectors.toList());
                    
        
        List<String> missingBaselineFiles = expectedBaselineFiles.stream()
                                            .filter( (ebf) ->
                                            {
                                                File f = new File(ebf);
                                                
                                                boolean accepted = !f.exists();
                                                
                                                if(accepted)
                                                {
                                                    System.err.println(" missing input file: " + ebf);
                                                }
                                                
                                                return accepted;
                                            })
                                            .collect(Collectors.toList());
                

        if(missingBaselineFiles.isEmpty())
        {
            System.out.println("All input files are present.");
        }
	else
        {
            System.err.println("The test suite detected that some input files are not present.");
        }
        
        return missingBaselineFiles;
    }
}
