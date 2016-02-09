
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Stream;

import org.onebeartoe.system.Commander;


public class OpenScadTestSuite
{
    private List<Path> openscadPaths;
    
    private PngGenerator pngGenerator;
    
    private Logger logger;
    
    private OpenScadTestSuite()
    {
	String name = getClass().getName(); 
	logger = Logger.getLogger(name);
	
	pngGenerator = new PngGenerator();
    }
    
    /**
     * 
     * @return a list of any files that did not pass the diff test
     */
    private List<String> compareImages()
    {
	List<String> errorFiles = new ArrayList();
	
	Stream.of(OpenScadCameraDirections.values() )
	.forEach((direction) -> 
        {
            openscadPaths.forEach((p) -> 
            {
        	boolean forceGeneration = false;
        	String baseline = DataSetValidator.baselineNameForReal(p, forceGeneration, direction);
        	
        	forceGeneration = true;
        	String proposedBaseline = DataSetValidator.baselineNameForReal(p, forceGeneration, direction);
        	
        	String systemCommand = "diff " + baseline + " " + proposedBaseline;
                Commander commander = new Commander(systemCommand);

                try 
                {
		    int exitCode = commander.execute();

		    // assume no problems will occur and set the exit code to 0; success		    
		    if(exitCode != 0)
		    {
			errorFiles.add(baseline);
			
			Consumer printall = (line) -> {System.out.println(line);};
			
			commander.getStderr()
				 .forEach(printall);
			
			commander.getStdout()
				 .forEach(printall);
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
    
    private String determinePath(String [] args)
    {
	String path;
	
        if (args.length > 1)
        {
            // a parameter besides the path was given, presumably for baseline generation
            path = args[1];
        }
        else
        {
            // assume the request is to run the test suite
            path = args[0];
        }
        
        return path;
    }

    private void generateBaselines() throws IOException, InterruptedException
    {
        System.out.println("test suite generating baselines, count: " + openscadPaths.size());

        // don't overwrite any existing baseline images
        boolean forcePngGeneration = false;
        
        pngGenerator.generatePngs(openscadPaths, forcePngGeneration);
    }

    private void generateProposedBaselines() throws IOException, InterruptedException
    {
        // create the proposed baseline images every time the test suite is run
        boolean forcePngGeneration = true;
        
        pngGenerator.generatePngs(openscadPaths, forcePngGeneration);	
    }
    
    public static void main(String[] args) throws Throwable
    {
        if (args.length == 0)
        {
            // the test suite needs at least one argument, the path to test
            printHelp();
        }
        else
        {
            OpenScadTestSuite testSuite = new OpenScadTestSuite();
            testSuite.serviceRequest(args);
        }
    }

    private static void printHelp() throws URISyntaxException, IOException
    {
        StringBuilder message = new StringBuilder();

        String resourcePath = "/help.text";
        URL url = OpenScadTestSuite.class.getResource(resourcePath);

        URI uri = url.toURI();

        Map<String, String> env = new HashMap<>();
        env.put("create", "true");
        FileSystem zipfs = FileSystems.newFileSystem(uri, env);

        Path inpath = Paths.get(uri);

        List<String> allLines = Files.readAllLines(inpath);

        allLines.forEach((line) -> {
            message.append(line);
            message.append(System.lineSeparator());
        });

        System.out.println(message);
    }

    private void runTestSuite(String[] args) throws Throwable
    {
        System.out.println("Welcome to the onebeartoe OpenSCAD test suite!");

        DataSetValidator inputValidator = new DataSetValidator();
        List<String> missingPngs = inputValidator.validate(openscadPaths);

        if (!missingPngs.isEmpty())
        {
            System.err.println("The test suite will not continue with missing baseline PNG images.");
        }
        else
        {
            System.out.println();
            System.out.println("Generating a proposed version of the .png  from each .oscad file...");
            System.out.println();

            generateProposedBaselines();
            
            System.out.println();
            System.out.println("The proposed baseline files are generated.");
            
            System.out.println();
            System.out.println("Comparing baseline images to the proposed baseline images...");
            System.out.println();
            
            List<String> errorFiles = compareImages();
            
            // Check if the diffs were successful
            if(errorFiles.size() == 0)
            {
        	System.out.println();
        	System.out.println("No test suite erros were detected.");
        	System.out.println("Thanks for using the onebeartoe test suite for OpenSCAD libraries.");
            }
            else
            {
        	
        	System.out.println();
        	System.out.println("The test suite detected errors with the baseline and proposed baseline PNG images.");
        	System.out.println("See the 'Binary files ... differ' message(s) above.");        	
            }
        }
    }

    private void serviceRequest(String[] args) throws Throwable
    {
        String path = determinePath(args);

        OpenScadFileFinder openScadFinder = new OpenScadFileFinder();
        Path inpath = FileSystems.getDefault().getPath(path);
        openscadPaths = openScadFinder.getFiles(inpath);

        if (args.length > 1)
        {
            if (args[0].equals("--generateBaselines"))
            {
                generateBaselines();
            }
            else
            {
                System.err.println("An unknown parameter was encountered: " + args[0]);
                printHelp();
            }
        }
        else
        {
            runTestSuite(args);
        }
    }
}