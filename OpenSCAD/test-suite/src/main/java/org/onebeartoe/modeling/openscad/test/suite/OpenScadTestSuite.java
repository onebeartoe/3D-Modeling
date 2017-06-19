
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.IOException;
import java.net.URI;
import java.net.URL;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Stream;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;

public class OpenScadTestSuite
{
    private List<Path> openscadPaths;
    
    private PngGenerator pngGenerator;
    
    private Logger logger;
    
    private static String OPENSCAD_REDIRECTION = "openscadRedirection";
    
    private OpenScadTestSuiteService testService;
    
    public OpenScadTestSuite()
    {
        String name = getClass().getName(); 
        logger = Logger.getLogger(name);

        pngGenerator = new PngGenerator();
        
        testService = new OpenScadTestSuiteService();
    }

    private void generateBaselines(boolean redirectOpenscad) throws IOException, InterruptedException
    {
        System.out.println("test suite generating baselines, count: " + openscadPaths.size());

        // don't overwrite any existing baseline images
        boolean forcePngGeneration = false;
        
        pngGenerator.generatePngs(openscadPaths, forcePngGeneration, redirectOpenscad);
    }

    /**
     * 
     * @return The count of proposed baseline images generated.
     * @throws IOException
     * @throws InterruptedException 
     */
    private int generateProposedBaselines(boolean redirectOpenscad) throws IOException, InterruptedException
    {
        // create the proposed baseline images every time the test suite is run
        boolean forcePngGeneration = true;
        
        boolean success = pngGenerator.generatePngs(openscadPaths, 
                                                    forcePngGeneration,
                                                    redirectOpenscad);
        int count;
        
        if(success)
        {
            count = openscadPaths.size();
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
    
    public static void main(String[] args) throws Throwable
    {
        Option outfile = Option.builder()
                        .required(false)
                        .longOpt(OPENSCAD_REDIRECTION)
                        .hasArg(true)
                        .build();        
        Options options = new Options();
        options.addOption(outfile);
        
        CommandLineParser parser = new DefaultParser();
        CommandLine cmd = parser.parse(options, args);
        
        List<String> remainingArgs = cmd.getArgList();

        boolean redirectOpenscad = cmd.hasOption(OPENSCAD_REDIRECTION);
        String message = redirectOpenscad ? "" : "not ";
        message += "gonna redirect openscad";
        System.out.println(message);
        
        if (args.length == 0)
        {
            // the test suite needs at least one argument, the path to test
            printHelp();
        }
        else
        {
            oneOrMoreArgs(args, redirectOpenscad);
        }
    }

    private static void oneOrMoreArgs(String [] args, boolean redirectOpenscad) throws Exception
    {
        // This block uses the start and end Instant to keep track of the 
        // total duration of the test run.
        printCommandLineArguments(args);

        Instant start = Instant.now();

        OpenScadTestSuite testSuite = new OpenScadTestSuite();
        testSuite.serviceRequest(args, redirectOpenscad);

        Instant end = Instant.now();

        ChronoUnit units = ChronoUnit.SECONDS;
        long duration = units.between(start,end);
        long minutes = duration / 60;
        long seconds = duration % 60;
        String message = "The test suite ran " + minutes + " minutes " + seconds + " seconds.";
        System.out.println();
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
//        *
        StringBuilder message = new StringBuilder();

        String resourcePath = "/help.text";
        URL url = OpenScadTestSuite.class.getResource(resourcePath);

        URI uri = url.toURI();

        Map<String, String> env = new HashMap<>();
        env.put("create", "true");
        
//        FileSystem zipfs = FileSystems.newFileSystem(uri, env);

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
            System.err.println("Try running '--generateBaselines' to generate the missing input files.");
        }
    }    
    
    private void runTestSuite(boolean skipProposedBaselineGeneration, boolean redirectOpenscad) throws Exception
    {
        System.out.println("Welcome to the onebeartoe OpenSCAD test suite!");

        DataSetValidator inputValidator = new DataSetValidator();
        List<String> missingPngs = inputValidator.validate(openscadPaths);
        printValidationResults(missingPngs);

        if (!missingPngs.isEmpty())
        {
            System.err.println();
            System.err.println("The test suite will not continue with missing baseline PNG images.");
        }
        else
        {
            boolean proposedBaselineError = false;
            if(skipProposedBaselineGeneration)
            {
                System.out.println("Generation of the proposed baselines PNGs is being skipped.");
            }
            else
            {
                System.out.println();
                System.out.println("The test suite is now generating proposed baseline images for each .oscad file.");
                System.out.println();
                
                int count = generateProposedBaselines(redirectOpenscad);
                
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

                List<String> errorFiles = testService.compareImages(openscadPaths);

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
    
    public void serviceRequest(String[] args, boolean redirectOpenscad) throws Exception
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
                    generateBaselines(redirectOpenscad);
                }
                else if(mode == RunMode.CLEANUP_LIST)
                {
                    printPngCleanupList();
                }
                else
                {
                    // the mode is 'run test suite'
                    runTestSuite(diffOnly, redirectOpenscad);
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