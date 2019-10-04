
package org.onebeartoe.modeling.openscad.test.suite;

import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import org.onebeartoe.application.duration.DurationService;
import org.onebeartoe.modeling.openscad.test.suite.utils.OpenScadTestSuiteService;
import java.time.Instant;
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
import org.onebeartoe.modeling.openscad.test.suite.model.ImageComparisonResult;
import org.onebeartoe.modeling.openscad.test.suite.model.OpenScadTestSuiteResults;

public class OpenScadTestSuite
{        
    private Logger logger;
    
    private static final String DELETE_PROPOSED_BASELINES = "deleteProposedBaselines";
    private static final String DIFF_ONLY = "diffOnly";
    public static final String GENERATE_BASELILNES = "generateBaselines";
    private static final String OPENSCAD_PATH = "openscadPath";
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
        
        Option deleteProposedBaselines = Option.builder()
                    .required(false)
                    .longOpt(DELETE_PROPOSED_BASELINES)
                    .hasArg(false)
                    .build();
        
        Option diffOnly = Option.builder()
                    .required(false)
                    .longOpt(DIFF_ONLY)
                    .build();
        
        Option openscadPath = Option.builder()
                                .hasArg()
                                .longOpt(OPENSCAD_PATH)
                                .desc("This is the path to the openscad execuable.")
                                .build();
        
        Options options = new Options();
        options.addOption(deleteProposedBaselines);
        options.addOption(diffOnly);
        options.addOption(generateBaselines);
        options.addOption(openscadPath);
        options.addOption(outfile);
        
        return options;
    }

//TODO: refactor this to use a onebeartoe CliApplet API    
    public static void main(String[] args) throws Throwable
    {
        Options options = buildOptions();
        try
        {
            RunProfile runProfile = parseRunProfile(args, options);

            Instant start = Instant.now();

            OpenScadTestSuiteService testService = new OpenScadTestSuiteService();
            
            OpenScadTestSuiteResults compareResults = testService.serviceRequest(runProfile);
            
            testService.printHighLevelErrorReport(runProfile, compareResults.getCompareResults().errorFiles);
            
            testService.saveErrorPngFilenames(compareResults.getCompareResults().errorFiles);
            
            testService.printLongestComparisons(compareResults.getCompareResults());
            
            testService.printProposedPngGenerationDurations(compareResults.getPngGenerationResults());

            Instant end = Instant.now();
        
            DurationService durationService = new DurationService();
            String message = durationService.durationMessage(start, end);
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
    
    /**
     * This method parses the command line arguments agains the Options object 
     * parameter.
     * 
     * This version produces baseline imags that match the ones created on the openscad 
     * build server, which uses version 2015.03-1 of OpenSCAD.
     * 
     * @param args
     * 
     * The openscad executable path is configurable on the command line.  Here 
     * are some sample '--openscadPath' values:
     * 
     *       "openscad"
     *       "C:\\opt\\openscad\\openscad-2017.04.05\\openscad"
     *       "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
     * 
     * @param options
     * @return
     * @throws ParseException 
     */
    private static RunProfile parseRunProfile(final String[] args, Options options) throws ParseException
    {
        CommandLineParser parser = new DefaultParser();
        CommandLine cmd = parser.parse(options, args);
        
        RunProfile runProfile = new RunProfile();
        
        if(cmd.hasOption(OPENSCAD_PATH))
        {
            runProfile.executablePath = cmd.getOptionValue(OPENSCAD_PATH);
        }
        else
        {
            runProfile.executablePath = "openscad";
        }
        runProfile.diffOnly = cmd.hasOption(DIFF_ONLY);
        runProfile.generateBaselines = cmd.hasOption(GENERATE_BASELILNES);
        runProfile.redirectOpenscad = cmd.hasOption(OPENSCAD_REDIRECTION);
        runProfile.deleteProposedBaseLines = cmd.hasOption(DELETE_PROPOSED_BASELINES);
        
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
        DELETE_PROPOSED_BASELINES,
        GENERATE_BASELINES,
        RUN_TEST_SUITE
    }
}
