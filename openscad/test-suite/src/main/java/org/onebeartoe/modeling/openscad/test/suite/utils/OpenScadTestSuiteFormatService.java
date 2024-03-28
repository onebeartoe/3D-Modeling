
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import org.onebeartoe.application.logging.SysoutLoggerFactory;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite;
import org.onebeartoe.modeling.openscad.test.suite.model.OneImageComparisonResult;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;

/**
 *
 */
public class OpenScadTestSuiteFormatService
{
    private static Logger logger = SysoutLoggerFactory.getLogger(OpenScadTestSuiteFormatService.class.getName());
    
    public static List<File> findProposedBaselines(Path inpath) throws IOException
    {
        ProposedBaselineFinder finder = new ProposedBaselineFinder();

        List<File> proposedBaselines = finder.find(inpath);

        return proposedBaselines;
    }    
    

    public static String extractTopLevel(RunProfile runProfile, String fullPath)
    {
        // remove the project path
        fullPath = fullPath.replace(runProfile.path, "");

        // account for running on MS Windows
        fullPath = fullPath.replace("\\", "/");

        int begin = 0;
        int end = fullPath.indexOf("/");

        String topLevel = null;

        if(end < 0)
        {
            // the file in the current directory
            topLevel = "";
        }
        else
        {
            // the OpenSCAD file is in the current directory
            topLevel = fullPath.substring(begin, end);
        }

        return topLevel;
    }    


    public static void printHighLevelErrorReport(RunProfile runProfile, List<OneImageComparisonResult> failedOpenScadFiles)
    {
        if(failedOpenScadFiles.size() > 0)
        {
            System.err.println("These top level directories have errors:");
        }

        Map<String, Integer> topLevelHits = new HashMap();

        failedOpenScadFiles.forEach(f ->
        {
            String topLevelKey = extractTopLevel(runProfile, f.getFile() );

            Integer count = topLevelHits.get(topLevelKey);
            if(count == null)
            {
                count = 1;
            }
            else
            {
                count += 1;
            }

            topLevelHits.put(topLevelKey, count);
        });

        int total = topLevelHits.values()
                                .stream()
                                .mapToInt(Integer::intValue)
                                .sum();

        if(total > 0)
        {
            System.out.println();
            System.out.println("top level count: " + total);
            System.out.println();

            topLevelHits.keySet()
                        .stream()
                        .sorted()
                        .forEach(key ->
                        {
                            System.out.println(key + ": " + topLevelHits.get(key) );
                        });

            System.out.println();
        }
    }

    public static void printValidationResults(List<String> missingBaselineFiles)
    {
        if (missingBaselineFiles.isEmpty())
        {
            String pwd = (new File(".")).getAbsolutePath();

            System.out.println("The current working directory is: " + pwd);
            System.out.println();

            System.out.println("All input files are present.");
        }
        else
        {
            int count = missingBaselineFiles.size();
            
            logger.severe("Some " + count + " test suite input files are not present.\n");
            
            logger.severe("Try running '--" + OpenScadCliTestSuite.GENERATE_BASELILNES +"' to generate the missing input files.\n");
        }
    }
    
}
