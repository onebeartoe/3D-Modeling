
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.util.List;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import static org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite.DELETE_PROPOSED_BASELINES;
import static org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite.GENERATE_BASELILNES;
import static org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite.OPENSCAD_PATH;
import static org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite.OPENSCAD_REDIRECTION;
import static org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite.printCommandLineArguments;
import org.onebeartoe.modeling.openscad.test.suite.model.RunProfile;
import org.onebeartoe.modeling.openscad.test.suite.utils.OpenScadFileFinder;

/**
 *
 */
public class RunProfileService
{
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
    public static RunProfile parseRunProfile(final String[] args, Options options) throws ParseException, IOException
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
        runProfile.diffOnly = cmd.hasOption(OpenScadCliTestSuite.DIFF_ONLY);
        runProfile.generateBaselines = cmd.hasOption(GENERATE_BASELILNES);
        runProfile.redirectOpenscad = cmd.hasOption(OPENSCAD_REDIRECTION);
        runProfile.deleteProposedBaseLines = cmd.hasOption(DELETE_PROPOSED_BASELINES);
        
        List<String> remainingArgs = cmd.getArgList();
        
        System.out.println("Remaining args:");
        remainingArgs.forEach(a -> System.out.println("\t" + a));
        System.out.println();
        
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
        
        OpenScadFileFinder openScadFinder = new OpenScadFileFinder();

        Path inpath = FileSystems.getDefault().getPath(runProfile.path);        
            
        if(inpath.toFile().isDirectory())
        {
            runProfile.openscadPaths = openScadFinder.getFiles(inpath);        
        }
        else
        {
            var file = inpath.toFile();
            
            if( file.exists() && file.getName().endsWith(".scad") )
            {
System.out.println("farto");                
            }
            else
            {
                var message = "File is not a file, nor a directory?!?: " + inpath.toString();
                
                throw new IllegalArgumentException(message);
            }
        }
        
        printCommandLineArguments(args);
        
        return runProfile;
    }    
}
