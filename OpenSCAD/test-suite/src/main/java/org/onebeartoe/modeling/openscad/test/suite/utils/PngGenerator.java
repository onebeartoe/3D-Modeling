
package org.onebeartoe.modeling.openscad.test.suite.utils;

import org.onebeartoe.modeling.openscad.test.suite.utils.DataSetValidator;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCameraDirections;
import org.onebeartoe.modeling.openscad.test.suite.RunProfile;

public class PngGenerator
{
    Logger logger;
    
    /**
     * Here is the refactor for driving whether the STD IOE of the openscad executable 
     * gets printed like regular or redirected to a file. 
     */
    private int generate(String commandList, RunProfile runProfile) throws IOException, InterruptedException
    {
//System.out.println("frt:a");        
        String [] strs = commandList.split("\\s+");
        
        List <String> command = Arrays.asList(strs);
        
        ProcessBuilder builder = new ProcessBuilder(command);
        Process jobProcess = builder.start();                
        int waitValue = jobProcess.waitFor();
        
        InputStream is = jobProcess.getInputStream();
        String stdout = new BufferedReader( new InputStreamReader(is))
                              .lines()
                              .collect(Collectors.joining("\n"));
                
        InputStream es = jobProcess.getErrorStream();
        String stderr = new BufferedReader( new InputStreamReader(es))
                              .lines()
                              .collect(Collectors.joining("\n"));

        if(runProfile.redirectOpenscad)
        {
//            System.out.println("redirection");
            //TODO: actually redirect the openscad output to a file
        }
        else
        {
System.out.println("frt:o");
            StringBuilder sb = new StringBuilder();
        
            // standard error
            sb.append( stderr.trim() );

            // standard out
            sb.append( stdout.trim() );

            System.out.println(commandList);
            System.out.println(sb.toString());
            System.out.println();
        }
        
        return waitValue;
    }
    
    public List<Boolean> generateDirectionalPngs(Path oscadInputFile, 
                                                 boolean forcePngGeneration,
                                                 RunProfile runProfile)
    {
    	List<Boolean> exitCodes = new ArrayList();

        Stream.of( OpenScadCameraDirections.values() )
                .parallel()
                .forEach((v) -> 
                {
		    try 
		    {
                        boolean exitCode = generateOneDirectionalPng(oscadInputFile, forcePngGeneration, v, runProfile);
                        exitCodes.add(exitCode);
		    } 
		    catch (Exception e)
		    {
		    	e.printStackTrace();
		    }		    
                });
        
        return exitCodes;
    }

// TODO: extract a generateOnePng from this method
    /**
     * This method calls the OpenSCAD executable to create a snapshot of a rendered .scad file.
     * 
     * Here is a sample invocation:
     * 
 * 			$ /cygdrive/c/opt/openscad/openscad-2015.03-2/openscad -o out.png --camera=0,0,0,0,0,0,350 space-invaders-scenes-CUSTOMIZER.scad
     * 
     * @param oscadInputFile
     * @param forceGeneration
     * @param direction
     * @return
     * @throws IOException
     * @throws InterruptedException
     */
    public boolean generateOneDirectionalPng(Path oscadInputFile, boolean forceGeneration, 
                                             OpenScadCameraDirections direction,
                                             RunProfile runProfile)
            throws IOException, InterruptedException
    {        
//        String openscadPath = "/cygdrive/c/opt/OpenSCAD/openscad-2015.03-1/openscad";
//        openscadPath = "C:\\opt\\openscad\\openscad-2015.03-2\\openscad";
//        openscadPath = "C:\\opt\\openscad\\openscad-2017.01.20\\openscad";
//        openscadPath = "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD";

        String outfileName = DataSetValidator.baselineNameFor(oscadInputFile, forceGeneration, direction);

        File outfile = new File(outfileName);

        int exitCode = -1;

        // test to see if the proposed baseline PNG file exists OR if the PNG is to 
        // be generated regardless of the file existing or not (generate-proposed-pngs.sh )
        if (!outfile.exists() || forceGeneration)
        {
            String infilePath = oscadInputFile.toString().replace("\\", "/");
            if (infilePath.startsWith("./"))
            {
                infilePath = infilePath.substring(2);
            }

            // The OpenSCAD executable --camera option takes these parameters: translatex,y,z,rotx,y,z,dist
            int distance = 250;
            String rotateParams = direction.getRotateParams().replaceAll(" ", "");
            
            String command = runProfile.executablePath
                    + " -o " + outfileName + " " + "--camera=0,0,0," + rotateParams + "," + distance + " " + infilePath;
            
            exitCode = generate(command, runProfile);
        }

        // an exit code of 0 is expected for successful execution of a system command 
        return exitCode == 0;
    }

    public boolean generatePngs(//List<Path> openscadPaths, 
                                boolean forcePngGeneration,
                                RunProfile runProfile) throws IOException,
            InterruptedException
    {
        List<Boolean> exitCodes = new ArrayList();

        runProfile.openscadPaths.stream().parallel().forEach((p) -> 
        {
            List<Boolean> directionalExitCodes = generateDirectionalPngs(p, 
                                                                         forcePngGeneration,
                                                                         runProfile);
            exitCodes.addAll(directionalExitCodes);
            
            if( directionalExitCodes.contains(false) )
            {
                System.err.println("An error occured with proposed baseline PNG:");
                System.err.println( p.toString() );
            }
        });

        boolean masterExitCode = true;

        for (Boolean ec : exitCodes)
        {
            if (!ec)
            {
                masterExitCode = false;
                
                // break out early, on the first occurrence of a failure
                break;
            }
        }

        return masterExitCode;
    }
}