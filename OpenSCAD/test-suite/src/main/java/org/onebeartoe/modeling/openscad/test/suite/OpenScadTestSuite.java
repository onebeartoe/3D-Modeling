
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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
			
			System.out.println("\n\n");
			System.out.println("Standard error: " + stderr);
                        System.out.println("Standard out: " + stdout);
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
            oneOrMoreArgs(args);
        }
    }

    private static void oneOrMoreArgs(String [] args) throws Exception
    {
        // This block uses the start and end Instant to keep track of the 
        // total duration of the test run.
        printCommandLineArguments(args);

        Instant start = Instant.now();

        OpenScadTestSuite testSuite = new OpenScadTestSuite();
        testSuite.serviceRequest(args);

        Instant end = Instant.now();

        ChronoUnit units = ChronoUnit.SECONDS;
        long duration = units.between(start,end);
        long minutes = duration / 60;
        long seconds = duration % 60;
        String message = "The test suite ran " + minutes + " minutes " + seconds + " seconds.";
        System.out.println(message);
    }
    
    private static void printCommandLineArguments(String [] args)
    {
        System.out.println("Commandline args:");
        Stream<String> stream = Arrays.stream(args);
        stream.forEach( System.out::println );
        System.out.println();
    }

    private static void printHelp() throws Exception
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
    
    private void printPngCleanupList()
    {
        StringBuilder sb = new StringBuilder();
        
        sb.append("\n" + "cleanup path:" + "\n\n");
        openscadPaths.forEach(p -> 
        {
            sb.append(p + "\n");
        });
        
        String message = sb.toString();
        
        logger.log(Level.INFO, message);
    }
    


    private void runTestSuite(boolean skipProposedBaselineGeneration) throws Exception
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
            if(skipProposedBaselineGeneration)
            {
                System.out.println("Generation of the proposed baselines PNGs is being skipped.");
            }
            else
            {
                System.out.println();
                System.out.println("Generating a proposed version of the .png  from each .oscad file...");
                System.out.println();
                
                generateProposedBaselines();
            }
            
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
        	System.out.println("No test suite errors were detected.");
        	System.out.println("Thanks for using the onebeartoe test suite for OpenSCAD libraries.");
            }
            else
            {
        	
        	System.out.println();
        	System.out.println("The test suite detected " + errorFiles.size() + " errors with the baseline and proposed baseline PNG images.");
        	System.out.println("See the 'Binary files ... differ' message(s) above.");        	
            }
        }
    }

    private String safePath(String [] args)
    {
        String path;
        
        if(args.length > 1)
        {
            // at least two arguments exists, use the second as the path 

            path = args[1];
        }
        else
        {
            // the 'generate baselines' option was given, use the current directory as the path

            path = ".";
        }
        
        return path;
    }
    
    private void serviceRequest(String[] args) throws Exception
    {        
        RunMode mode;
        String path;
        
        if(args.length == 0)
        {
            printHelp();
        }
        else 
        {
            // at least one command line argument exists
            
            boolean diffOnly = false;
            
            if( args[0].equals("--generateBaselines") )
            {
                mode = RunMode.GENERATE_BASELINES;
                
                path = safePath(args);
            }
            else if( args[0].equals("--diffOnly") )
            {
                diffOnly = true;
                
                mode = RunMode.RUN_TEST_SUITE;
                
                path = safePath(args);
            }
            else if( args[0].equals("--cleanupList") )
            {
                mode = RunMode.CLEANUP_LIST;
                path = safePath(args);
            }
            else
            {
                mode = RunMode.RUN_TEST_SUITE;
                
                // use the first argument as the path;
                path = args[0];
            }

            OpenScadFileFinder openScadFinder = new OpenScadFileFinder();
            Path inpath = FileSystems.getDefault().getPath(path);
            
            try
            {
                openscadPaths = openScadFinder.getFiles(inpath);

                if(mode == RunMode.GENERATE_BASELINES)
                {
                    generateBaselines();
                }
                else if(mode == RunMode.CLEANUP_LIST)
                {
                    printPngCleanupList();
                }
                else
                {
                    // the mode is 'run test suite'
                    runTestSuite(diffOnly);
                }                
            }
            catch(NoSuchFileException nsfe)
            {
                printHelp();
                
                nsfe.printStackTrace();
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
        }
    }
    
    private enum RunMode
    {
        CLEANUP_LIST,
        GENERATE_BASELINES,
        RUN_TEST_SUITE
    }
}