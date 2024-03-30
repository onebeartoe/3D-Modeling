
package org.onebeartoe.modeling.openscad.test.suite;

import java.nio.file.Path;
import java.time.Duration;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import org.onebeartoe.application.duration.DurationService;
import org.onebeartoe.modeling.openscad.test.suite.utils.OpenScadTestSuiteService;
import java.time.Instant;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
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
import org.onebeartoe.application.logging.SysoutLoggerFactory;
import org.onebeartoe.modeling.openscad.test.suite.model.OneImageComparisonResult;
import org.onebeartoe.modeling.openscad.test.suite.utils.Help;
import org.onebeartoe.modeling.openscad.test.suite.model.OpenScadTestSuiteResults;
import org.onebeartoe.modeling.openscad.test.suite.utils.OpenScadTestSuiteFormatService;

public class OpenScadCliTestSuite
{        
    private static Logger logger;
    
    public static final String DELETE_PROPOSED_BASELINES = "deleteProposedBaselines";
    public static final String DIFF_ONLY = "diffOnly";
    public static final String GENERATE_BASELILNES = "generateBaselines";
    public static final String OPENSCAD_PATH = "openscadPath";
    public static final String OPENSCAD_REDIRECTION = "openscadRedirection";
    
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
        String name = OpenScadCliTestSuite.class.getName(); 
        
        logger = SysoutLoggerFactory.getLogger(name);

        Options options = buildOptions();

        Instant start = Instant.now();
        
        RunProfileService profileService = new RunProfileService();

        try
        {
            RunProfile runProfile =profileService.parseRunProfile(args, options);

            OpenScadTestSuiteService testService = new OpenScadTestSuiteService();
            
            OpenScadTestSuiteResults compareResults = testService.serviceRequest(runProfile);
            
            OpenScadTestSuiteFormatService.printHighLevelErrorReport(runProfile, compareResults.getCompareResults().errorFiles);
            
            testService.saveErrorPngFilenames(compareResults.getCompareResults().errorFiles);
            
            if(runProfile.mode == RunMode.RUN_TEST_SUITE)
            {
                List<OneImageComparisonResult> sortedComparisonResults = testService.longestComparisons(compareResults.getCompareResults());
                System.out.println();
                System.out.println("PNG comparison durations:");        
                sortedComparisonResults.forEach(System.out::println);

                System.out.println();
                System.out.println("proposed PNG generation durations:");            
                Map<Path, Duration> sortedResults = testService.proposedPngGenerationDurations(compareResults.getPngGenerationResults());

                sortedResults.forEach( (k, v) -> 
                {
                    System.out.println(v.getSeconds() + "." + v.getNano() + " - " + k); 
                });

                logger.info("\n");
            }
        }
        catch(UnrecognizedOptionException uoe)
        {
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("java -jar openscad-test-suite.jar [path]", options);
            Help h = new Help();
            h.printHelp();
        }            

        Instant end = Instant.now();
    
        DurationService durationService = new DurationService();
        String message = "The test suite ran " + durationService.durationMessage(start, end);
        logger.info(message);
    }
    
    public static void printCommandLineArguments(String [] args)
    {
        System.out.println("Commandline args:");
        Stream<String> stream = Arrays.stream(args);
        stream.forEach(a ->  System.out.println("\t" + a) );
        System.out.println();
        System.out.println();
        System.out.println();
        System.out.println();
        System.out.println();
        System.out.println();
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
