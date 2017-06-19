
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * This class provides methods used in the OpenSCAD test suite.
 * 
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class OpenScadTestSuiteService 
{
    private Logger logger;

    public OpenScadTestSuiteService()
    {
        String name = getClass().getName(); 
        logger = Logger.getLogger(name);
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
}