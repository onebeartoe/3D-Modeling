
package org.onebeartoe.modeling.openscad.test.suite;

import org.onebeartoe.modeling.openscad.test.suite.utils.OpenScadTestSuiteService;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Stream;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.apache.commons.cli.UnrecognizedOptionException;
import org.onebeartoe.modeling.openscad.test.suite.utils.Help;

public class OpenScadTestSuite
{        
    private Logger logger;
    
    private static final String DIFF_ONLY = "diffOnly";
    public static final String GENERATE_BASELILNES = "generateBaselines";
    private static final String OPENSCAD_REDIRECTION = "openscadRedirection";
    
    public OpenScadTestSuite()
    {
        String name = getClass().getName(); 
        logger = Logger.getLogger(name);    
    }
    
    private static Options buildOptions()
    {
        Option outfile = Option.builder()
                        .required(false)
                        .longOpt(OPENSCAD_REDIRECTION)
                        .hasArg(true)
                        .build();
        
        Option generateBaselines = Option.builder()
                    .required(false)
                    .longOpt(GENERATE_BASELILNES)
                    .build();
        
        Option diffOnly = Option.builder()
                    .required(false)
                    .longOpt(DIFF_ONLY)
                    .build();
        
        Options options = new Options();
        options.addOption(diffOnly);
        options.addOption(generateBaselines);
        options.addOption(outfile);
        
        return options;
    }
    
    private static String durationMessage(Instant start, Instant end)
    {
        ChronoUnit units = ChronoUnit.SECONDS;
        long duration = units.between(start,end);
        long minutes = duration / 60;
        long seconds = duration % 60;
        String message = "The test suite ran " + minutes + " minutes " + seconds + " seconds.";                
                
        return message;
    }
    
    public static void main(String[] args) throws Throwable
    {
        Options options = buildOptions();
        try
        {
            RunProfile runProfile = parseRunProfile(args, options);

            Instant start = Instant.now();

            OpenScadTestSuiteService testService = new OpenScadTestSuiteService();
            testService.serviceRequest(runProfile);

            Instant end = Instant.now();

            String message = durationMessage(start, end);
            System.out.println();
            System.out.println(message);
        }
        catch(UnrecognizedOptionException uoe)
        {
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("java -jar openscad-test-suite.jar [path]", options);
            Help h = new Help();
            h.printHelp();
        }
    }
    
    private static RunProfile parseRunProfile(final String[] args, Options options) throws ParseException
    {
        CommandLineParser parser = new DefaultParser();
        CommandLine cmd = parser.parse(options, args);
        
        RunProfile runProfile = new RunProfile();
        
        // TODO: Do not hard code the openscad executable path
//        runProfile.executablePath = "C:\\opt\\openscad\\openscad-2017.01.20\\openscad";
        // TODO: okay
        // This version produces baseline imags that match what is on the openscad 
        // build server, OpenSCAD version 2015.03-1
        runProfile.executablePath = "C:\\opt\\openscad\\openscad-2017.04.05\\openscad";
        // TODO: okay
//        runProfile.executablePath = "C:\\opt\\openscad\\openscad-2015.03-2\\openscad";
        
        runProfile.diffOnly = cmd.hasOption(DIFF_ONLY);
        runProfile.generateBaselines = cmd.hasOption(GENERATE_BASELILNES);
        runProfile.redirectOpenscad = cmd.hasOption(OPENSCAD_REDIRECTION);
        
        List<String> remainingArgs = cmd.getArgList();
        
        System.out.println("Remaining args:");
        remainingArgs.forEach(a -> System.out.println(a));

        if( remainingArgs.isEmpty() )
        {
            // by default, use the current directory as the path if no 
            // argument is given
            runProfile.path = ".";
        }
        else
        {
            // use the first argument as the path to the .scad files
            runProfile.path = remainingArgs.get(0);
        }
        
        printCommandLineArguments(args);
        
        return runProfile;
    }
    
    private static void printCommandLineArguments(String [] args)
    {
        System.out.println("Commandline args:");
        Stream<String> stream = Arrays.stream(args);
        stream.forEach( System.out::println );
        System.out.println();
    }
    
    public enum RunMode
    {
        CLEANUP_LIST,
        GENERATE_BASELINES,
        RUN_TEST_SUITE
    }
}