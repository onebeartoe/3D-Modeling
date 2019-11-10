
//TODO dos2unix this file and see how to remove ^M from Netbeans formatting

package org.onebeartoe.modeling.openscad.test.suite.utils;

import org.onebeartoe.modeling.openscad.test.suite.model.ImageComparisonResult;
import org.onebeartoe.modeling.openscad.test.suite.model.GeneratePngBaselineResults;
import org.onebeartoe.modeling.openscad.test.suite.model.OneImageComparisonResult;
import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCameraDirections;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite;
import org.onebeartoe.modeling.openscad.test.suite.model.DirectoryProfile;
import org.onebeartoe.modeling.openscad.test.suite.model.OpenScadTestSuiteResults;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import static org.onebeartoe.modeling.openscad.test.suite.utils.PngGenerator.loadDirectoryProperties;
import org.onebeartoe.system.CommandResults;
import org.onebeartoe.system.command.SystemCommand;
import org.onebeartoe.system.command.imagemagick.Compare;

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
    public OpenScadTestSuiteResults serviceRequest(RunProfile runProfile) throws IOException, ImageComparisonException, InterruptedException
    {
        OpenScadTestSuiteResults results = null;

        OpenScadCliTestSuite.RunMode mode;

//TODO: the first hachifufoo
        if(runProfile.generateBaselines)
        {
            mode = OpenScadCliTestSuite.RunMode.GENERATE_BASELINES;
        }
        else if(runProfile.deleteProposedBaseLines)
        {
            mode = OpenScadCliTestSuite.RunMode.DELETE_PROPOSED_BASELINES;
        }
        else if(runProfile.diffOnly)
        {
            mode = OpenScadCliTestSuite.RunMode.RUN_TEST_SUITE;
        }
        else
        {
            mode = OpenScadCliTestSuite.RunMode.RUN_TEST_SUITE;
        }

        OpenScadFileFinder openScadFinder = new OpenScadFileFinder();
        Path inpath = FileSystems.getDefault().getPath(runProfile.path);

//        try
        {
            runProfile.openscadPaths = openScadFinder.getFiles(inpath);

            if(mode == OpenScadCliTestSuite.RunMode.GENERATE_BASELINES)
            {
                results = new OpenScadTestSuiteResults();

                results.setCompareResults( new ImageComparisonResult() );
                
                GeneratePngBaselineResults gpnr = new GeneratePngBaselineResults();
                
                results.setPngGenerationResults( gpnr );
                
                generateBaselines(runProfile);
            }
            else if( mode == OpenScadCliTestSuite.RunMode.DELETE_PROPOSED_BASELINES)
            {
                deleteProposedBaselines(inpath);
            }
            else
            {
                // the mode is 'run test suite'
                results = runTestSuite(runProfile);

                ImageComparisonResult compareResults = results.getCompareResults();

                if(compareResults.exceptionThrown)
                {
                    int count = compareResults.errorFiles.size();

                    String message = "the test suite failed with " + count + " errors";

                    throw new ImageComparisonException(message);
                }
            }
        }
//        catch(Exception nsfe)
//        {
//            File pwd = new File(".");
//            System.err.println("pwd: " + pwd.getAbsolutePath() );
//
//            nsfe.printStackTrace();
//
//            throw new Exception(nsfe);
//        }

        return results;
    }

    private void generateBaselines(RunProfile runProfile) throws IOException, InterruptedException
    {
        int count = runProfile.openscadPaths.size() * 4;
        
        System.out.println("The test suite is generating baselines. count: " + count);
        System.out.println();

        // don't overwrite any existing baseline images
        boolean forcePngGeneration = false;

//TODO: Move forcePngGeneration into the RunProfile class.
        pngGenerator.generatePngs(forcePngGeneration, runProfile);
    }

    /**
     *
     *
     *
     * @param runProfile
     * @return The count of proposed baseline images generated.
     * @throws IOException
     * @throws InterruptedException
     */
    public GeneratePngBaselineResults generateProposedBaselines(RunProfile runProfile) throws IOException, InterruptedException
    {
        // create the proposed baseline images every time the test suite is run
        boolean forcePngGeneration = true;

        GeneratePngBaselineResults results = pngGenerator.generatePngs(forcePngGeneration,
                runProfile);

        boolean success = results.isSuccess();

        if(success)
        {
            System.out.println("PNG generation succeeded.");
        }
        else
        {
            System.err.println();
            System.err.println("ERROR detected: Some PNGs were not generated.");
        }

        return results;
    }

    /**
     *
     * @param runProfile
     * @return This method retuns a list of files that had an error with
     *         baseline and proposed baseline comparison.
     */
    public ImageComparisonResult compareImages(RunProfile runProfile)
    {
        System.out.println("Comparing baseline images to the proposed baseline images...");
        System.out.println();

        ImageComparisonResult results = compareImages(runProfile.openscadPaths);

        // verify Check if the diffs were successful
        if(results.errorFiles.isEmpty() && !results.exceptionThrown)
        {
            System.out.println("No test suite errors were detected.");
            System.out.println();
            System.out.println("Thanks for using the onebeartoe test suite for OpenSCAD libraries.");
        }
        else
        {
            if(results.exceptionThrown)
            {
                System.out.println("Image comparison exceptions occured.");
            }
            else
            {
                System.out.println("The test suite detected " + results.errorFiles.size() + " errors with the baseline and proposed baseline PNG images.");
            }

            System.out.println();

            System.out.println("See the compare commands above.");
        }

        return results;
    }

    /**
     *
     * @return a list of any files that did not pass the diff test
     */
    private ImageComparisonResult compareImages(List<Path> openscadPaths)
    {
        Class c = Collection.class;

        ImageComparisonResult comparisonResults = new ImageComparisonResult();

	Stream.of( OpenScadCameraDirections.values() )
                .parallel()
              .forEach((OpenScadCameraDirections direction) ->
        {
            openscadPaths.parallelStream().forEach((Path p) ->
            {
                DirectoryProfile directoryProfile = new DirectoryProfile();
                Path parent = p.getParent();
                directoryProfile.setPath(parent);

                try
                {
                    loadDirectoryProperties(directoryProfile);
                }
                catch (IOException ex)
                {
                    logger.severe("could not load directory properties for: " + p.toString() + " - " + ex.getMessage() );
                }

                if( directoryProfile.getSkipPngGeneration() )
                {
                    System.out.println("Image comparison is skipped for: " + p.toString() + " - " + direction);
                }
                else
                {
                    compareOneImage(p, direction, comparisonResults);
                }
            });
        });

	return comparisonResults;
    }

    private void compareOneImage(Path p, OpenScadCameraDirections direction, ImageComparisonResult comparisonResults)
    {
        boolean forceGeneration = false;
        String baseline = DataSetValidator.baselineNameFor(p, forceGeneration, direction);

        forceGeneration = true;
        String proposedBaseline = DataSetValidator.baselineNameFor(p, forceGeneration, direction);

        OneImageComparisonResult result = new OneImageComparisonResult();
        
        result.setFile(baseline);        
        
        try
        {
            LocalDateTime start = LocalDateTime.now();

            SystemCommand diffCommand = new Compare(baseline, proposedBaseline);
            CommandResults results = diffCommand.execute();

            LocalDateTime end = LocalDateTime.now();

            Duration duration = Duration.between(start, end);

            result.setDuration(duration);

            // check if the exit code is 0 for success
            if(results.exitCode == 0)
            {
                comparisonResults.successFiles.add(result);
            }
            else
            {
                comparisonResults.exceptionThrown = true;
            
                comparisonResults.errorFiles.add(result);

                System.out.println( results.processedStdErr.trim() );
                System.out.print( results.processedStdOut.trim() );
            }
        }
        catch (Exception e)
        {
            comparisonResults.exceptionThrown = true;

            result.setDuration(Duration.ofMillis( Long.MAX_VALUE ));
                        
            comparisonResults.errorFiles.add(result);

//                System.out.println( results.processedStdErr.trim() );
//                System.out.print( results.processedStdOut.trim() );            
            
            String message = "An error occured while executing a diff command.";
            logger.log(Level.SEVERE, message, e);
        }
    }

    private void deleteProposedBaselines(Path inpath) throws IOException
    {
        // find all the proposed baseline images
        List<File> proposedBaselines = findProposedBaselines(inpath);

        // and delete them
        proposedBaselines.forEach( pb ->
        {
            System.out.println("deleteing: " + pb.getPath() );

            pb.delete();
        });
    }

//TODO: move this to a TestSuiteReultsService class
    private String extractTopLevel(RunProfile runProfile, String fullPath)
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

    private List<File> findProposedBaselines(Path inpath) throws IOException
    {
        ProposedBaselineFinder finder = new ProposedBaselineFinder();

        List<File> proposedBaselines = finder.find(inpath);

        return proposedBaselines;
    }

//TODO: move this to a TestSuiteReultsService class
    public void printHighLevelErrorReport(RunProfile runProfile, List<OneImageComparisonResult> failedOpenScadFiles)
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

    public void printOpernScadVersion(RunProfile runProfile)
    {
// TODO: print the version of OpenSCAD
    }

//TODO: move this to a TestSuiteReultsService class
    public void printValidationResults(List<String> missingBaselineFiles)
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
            System.err.println("Some " + count + " test suite input files are not present.");
            System.err.println();
            System.err.println("Try running '--" + OpenScadCliTestSuite.GENERATE_BASELILNES +"' to generate the missing input files.");
        }
    }

    private OpenScadTestSuiteResults runTestSuite(RunProfile runProfile) throws IOException, InterruptedException //throws Exception
    {
        GeneratePngBaselineResults pngGenerationResults = null;

        ImageComparisonResult compareResults;

        DataSetValidator inputValidator = new DataSetValidator();
        List<String> missingPngs = inputValidator.validate(runProfile.openscadPaths);
        printValidationResults(missingPngs);

        if (!missingPngs.isEmpty())
        {
            compareResults = new ImageComparisonResult();

            compareResults.exceptionThrown = true;

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
                System.out.println("The test suite is now generating proposed baseline images for each .scad file.");
                System.out.println();

                printOpernScadVersion(runProfile);

                pngGenerationResults = generateProposedBaselines(runProfile);

                int count = pngGenerationResults.getPathDurations().size();

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
                compareResults = new ImageComparisonResult();

                compareResults.exceptionThrown = true;

                // halt the test execution and let the user know about errors
                String message = "Not all proposed baseline PNGs were generated.  ";
                message += "Please correct the errors to allow the test suite to continue";

                System.err.println(message);
            }
            else
            {
                compareResults = compareImages(runProfile);
            }
        }

        OpenScadTestSuiteResults testSuiteResults = new OpenScadTestSuiteResults();

        testSuiteResults.setCompareResults(compareResults);
        testSuiteResults.setPngGenerationResults(pngGenerationResults);

        return testSuiteResults;
    }

//TODO: move this to a TestSuiteReultsService class
    public void saveErrorPngFilenames(List<OneImageComparisonResult> errorFiles) throws IOException
    {
        File pwd = new File(".");

        final List<String> filepaths = new ArrayList();

        errorFiles.forEach(ef ->
        {
            filepaths.add(ef.getFile() );

            String proposed = ef.getFile().replace("-baseline.", "-proposed-baseline.");
            filepaths.add(proposed);
        });

        // correct the paths for the pwd on the build server (Travis-CI)
        String pathPrefix = "openscad/models/";
        List<String> lines = filepaths.stream()
                     .map(l -> pathPrefix + l)
                     .collect( Collectors.toList() );

        Path outpath = Paths.get("target/errorred-pngs.text");
        File parent = outpath.getParent().toFile();
        if( parent.exists() )
        {
            Files.write(outpath, lines);
        }
        else
        {
            System.out.println();
            System.out.print("The target/ directory does not exist: " + parent.getAbsolutePath() );
            System.out.println(", so the errorred file names are not saved.");
            System.out.println();
            
            System.out.println("The pwd is: " + pwd.getAbsolutePath() );
        }
    }

//TODO: move this to a TestSuiteReultsService class
    public List<OneImageComparisonResult> longestComparisons(ImageComparisonResult compareResults)
    {
        int limit = 15;

        List<OneImageComparisonResult> allResults = new ArrayList();

        allResults.addAll(compareResults.errorFiles);
        allResults.addAll(compareResults.successFiles);

        int total = allResults.size();

        int skip = total - limit;

        skip = skip < 0 ? 0 : skip;

        List<OneImageComparisonResult> sortedResults = allResults.stream()
                .sorted( Comparator.comparingLong(oicr ->  oicr.getDuration().toMillis() ) )
                .skip(skip)
                .collect(Collectors.toList());

        return sortedResults;
    }

//TODO: move this to a TestSuiteReultsService class
    public Map<Path, Duration> proposedPngGenerationDurations(GeneratePngBaselineResults results)
    {
        int limit = 15;

        int total = results.getPathDurations().size();

        int skip = total - limit;

        skip = skip < 0 ? 0 : skip;

        Map<Path, Duration> sortedMap = results.getPathDurations()
                .entrySet()
                .stream()
                .sorted((Map.Entry.<Path, Duration>comparingByValue()))
                .skip(skip)
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

        return sortedMap;
    }
}
