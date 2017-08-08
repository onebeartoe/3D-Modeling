
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.FileSystems;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCameraDirections;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadTestSuite;
import org.onebeartoe.modeling.openscad.test.suite.RunProfile;

/**
 * This class provides methods used in the OpenSCAD test suite.
 * 
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class OpenScadTestSuiteService 
{
    private Logger logger;
    
    private PngGenerator pngGenerator;    

    public OpenScadTestSuiteService()
    {
        String name = getClass().getName(); 
        logger = Logger.getLogger(name);
        
        pngGenerator = new PngGenerator();        
    }
    
    /**
     * It seems like this method should be refactored.
     * 
     */
    public void serviceRequest(RunProfile runProfile) throws Exception
    {
        OpenScadTestSuite.RunMode mode;        
        {
// the ifrst hachifufoo
            if(runProfile.generateBaselines)
            {
                mode = OpenScadTestSuite.RunMode.GENERATE_BASELINES;
            }
            else if(runProfile.diffOnly)
            {                
                mode = OpenScadTestSuite.RunMode.RUN_TEST_SUITE;
            }
            else
            {
                mode = OpenScadTestSuite.RunMode.RUN_TEST_SUITE;
            }

            OpenScadFileFinder openScadFinder = new OpenScadFileFinder();
            Path inpath = FileSystems.getDefault().getPath(runProfile.path);
            
            try
            {
                runProfile.openscadPaths = openScadFinder.getFiles(inpath);

                if(mode == OpenScadTestSuite.RunMode.GENERATE_BASELINES)
                {
                    generateBaselines(runProfile);
                }
                else
                {
                    // the mode is 'run test suite'
                    runTestSuite(runProfile);
                }                
            }
            catch(NoSuchFileException nsfe)
            {
                Help h = new Help();
                h.printHelp();
                
                File pwd = new File(".");
                System.err.println("pwd: " + pwd.getAbsolutePath() );
                
                nsfe.printStackTrace();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        }
    }    

    private void generateBaselines(RunProfile runProfile) throws IOException, InterruptedException
    {
        System.out.println("test suite generating baselines, count: " + runProfile.openscadPaths.size());

        // don't overwrite any existing baseline images
        boolean forcePngGeneration = false;

//TODO: Move forcePngGeneration into the RunProfile class.
        pngGenerator.generatePngs(runProfile.openscadPaths, forcePngGeneration, runProfile);
    }

    /**
     * 
     * @return The count of proposed baseline images generated.
     * @throws IOException
     * @throws InterruptedException 
     */
    private int generateProposedBaselines(RunProfile runProfile) throws IOException, InterruptedException
    {
        // create the proposed baseline images every time the test suite is run
        boolean forcePngGeneration = true;
        
        boolean success = pngGenerator.generatePngs(runProfile.openscadPaths, 
                                                    forcePngGeneration,
                                                    runProfile);
        int count;
        
        if(success)
        {
            count = runProfile.openscadPaths.size();
        }
        else
        {
//TODO: this should use a successCount returned by pngGenerator.generatePngs()
            count = -1;
            
            System.err.println();
            System.err.println("ERROR detected: Some PNGs were not generated.");
        }
        
        return count;
    }
    
    /**
     * 
     * @return a list of any files that did not pass the diff test
     */
    public List<String> compareImages(List<Path> openscadPaths)
    {
	List<String> errorFiles = new ArrayList();
	
        Class c = Collection.class;
        
	Stream.of( OpenScadCameraDirections.values() )
                .parallel()
              .forEach((direction) -> 
        {
            openscadPaths.parallelStream().forEach((p) -> 
            {
        	boolean forceGeneration = false;
        	String baseline = DataSetValidator.baselineNameFor(p, forceGeneration, direction);
        	
        	forceGeneration = true;
        	String proposedBaseline = DataSetValidator.baselineNameFor(p, forceGeneration, direction);
        	
        	String systemCommand = "diff " + baseline + " " + proposedBaseline;

                try 
                {
                    String [] strs = systemCommand.split("\\s+");

                    List <String> command = Arrays.asList(strs);

                    ProcessBuilder builder = new ProcessBuilder(command);
                    Process jobProcess = builder.start();                
                    int exitCode = jobProcess.waitFor();

                    InputStream is = jobProcess.getInputStream();
                    String stdout = new BufferedReader( new InputStreamReader(is))
                                          .lines()
                                          .collect(Collectors.joining("\n"));

                    InputStream es = jobProcess.getErrorStream();
                    String stderr = new BufferedReader( new InputStreamReader(es))
                                          .lines()
                                          .collect(Collectors.joining("\n"));                    

		    // check if the exit code is 0 for success
		    if(exitCode != 0)
		    {
			errorFiles.add(baseline);
			
                        System.out.println( stderr.trim() );
                        System.out.print( stdout.trim() );
		    }
		} 
                catch (Exception e) 
                {
                    String message = "An error occured while executing a diff command.";
                    logger.log(Level.SEVERE, message, e);
		}
            });
        });
	
	return errorFiles;
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
            int count = missingBaselineFiles.size();
            System.err.println("Some " + count + " test suite input files are not present.");
            System.err.println();
            System.err.println("Try running '--" + OpenScadTestSuite.GENERATE_BASELILNES +"' to generate the missing input files.");
        }
    }
    
    private void runTestSuite(RunProfile runProfile) throws Exception
    {
        System.out.println("Welcome to the onebeartoe OpenSCAD test suite!");

        DataSetValidator inputValidator = new DataSetValidator();
        List<String> missingPngs = inputValidator.validate(runProfile.openscadPaths);
        printValidationResults(missingPngs);

        if (!missingPngs.isEmpty())
        {
            System.err.println();
            System.err.println("The test suite will not continue with missing baseline PNG images.");
        }
        else
        {
            boolean proposedBaselineError = false;
            
            boolean skipProposedBaselineGeneration = runProfile.diffOnly;
            
            if(skipProposedBaselineGeneration)
            {
                System.out.println("Generation of the proposed baselines PNGs is being skipped.");
            }
            else
            {
                System.out.println();
                System.out.println("The test suite is now generating proposed baseline images for each .oscad file.");
                System.out.println();
                
                int count = generateProposedBaselines(runProfile);
                
                // check if the count is less than 0
                if(count < 0)
                {
                    proposedBaselineError = true;
                }
                else
                {
                    System.out.println();
                    System.out.println("Proposed baselines were generated for "
                            + count
                            + " OpenSCAD files.");
                }
            }

            if(proposedBaselineError)
            {
                // halt the test execution and let the user know about errors
                String message = "Not all proposed baseline PNGs were generated.  ";
                message += "Please correct the errors to allow the test suite to continue";
                
                System.err.println(message);
            }
            else
            {
                System.out.println();
                System.out.println("Comparing baseline images to the proposed baseline images...");

                List<String> errorFiles = compareImages(runProfile.openscadPaths);

                // Check if the diffs were successful
                if(errorFiles.size() == 0)
                {
                    System.out.println();
                    System.out.println("No test suite errors were detected.");
                    System.out.println();
                    System.out.println("Thanks for using the onebeartoe test suite for OpenSCAD libraries.");
                }
                else
                {
                    System.out.println( System.lineSeparator() );
                    System.out.println("The test suite detected " + errorFiles.size() + " errors with the baseline and proposed baseline PNG images.");
                    System.out.println();
                    System.out.println("See the 'Binary files ... differ' message(s) above.");        	
                }                
            }
        }
    }    
}