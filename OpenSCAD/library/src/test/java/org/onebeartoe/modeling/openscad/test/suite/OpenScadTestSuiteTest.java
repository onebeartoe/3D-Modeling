
package org.onebeartoe.modeling.openscad.test.suite;

import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import org.onebeartoe.modeling.openscad.test.suite.utils.DataSetValidator;
import org.onebeartoe.modeling.openscad.test.suite.utils.OpenScadFileFinder;
import org.onebeartoe.modeling.openscad.test.suite.utils.OpenScadTestSuiteService;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

/**
 *
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class OpenScadTestSuiteTest 
{
    private Logger logger;
    
    private RunProfile runProfile;
    
    private OpenScadTestSuiteService testService;
    
    public OpenScadTestSuiteTest() throws Exception
    {
        logger = Logger.getLogger( getClass().getName() );
        
        testService = new OpenScadTestSuiteService();

        runProfile = new RunProfile();

        runProfile.executablePath = "openscad";
//TODO: use the nightly version, since it is the latest version?
//        runProfile.executablePath = "openscad-nightly";

        runProfile.path = "src/main/openscad/";
        
        OpenScadFileFinder openScadFinder = new OpenScadFileFinder();
        Path inpath = FileSystems.getDefault().getPath(runProfile.path);

        runProfile.openscadPaths = openScadFinder.getFiles(inpath);
        runProfile.redirectOpenscad = false;
        
        DataSetValidator inputValidator = new DataSetValidator();
        List<String> missingPngs = inputValidator.validate(runProfile.openscadPaths);
        testService.printValidationResults(missingPngs);

        if (!missingPngs.isEmpty())
        {   
            String message = "The test suite will not continue with missing baseline PNG images.";
            
            System.err.println();
            System.err.println(message);

            throw new Exception(message);
        }

        int count = testService.generateProposedBaselines(runProfile);

        // check if the count is less than 0
        if(count < 0)
        {
            String message = "There was an error with proposed baseline generation.";
            
            throw new Exception(message);
        }        
    }
    
    @DataProvider(name="errorFiles")
    public Object[][] getErrorFiles() throws Exception
    {
        List<String> compareImages = testService.compareImages(runProfile);

        int parameterCount = 1;
        
        List<Object []> rows = compareImages.stream()
                .sorted()
                .map( l -> 
                {
                    Object [] array = new Object[parameterCount];
                    
                    array[0] = l;
                    
                    return array;
                }).collect(Collectors.toList());
        
        Object[][] data = new Object[rows.size()][parameterCount];        
        
        int r = 0;        
        for(Object [] row : rows)
        {
            data[r] = row;
            
            r++;
        }
        
        return data;
    }    

    @Test(dataProvider="errorFiles", 
          groups = {"openscad-test-suite"})
    /**
     * Any parameter passed to this test represents a file that failed baseline to 
     * proposed baseline comparison; i.e. all executions of this test are 
     * expected to file.
     */
    public void reportErros(String comparisonFile) throws Exception
    {        
        String message = "The comparison failed for: " + comparisonFile;
        
        throw new Exception(message);
    }
}