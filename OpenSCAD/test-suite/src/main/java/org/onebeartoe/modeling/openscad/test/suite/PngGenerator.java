
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Stream;

import org.onebeartoe.system.Commander;

public class PngGenerator
{
    Logger logger;
    
    private int generate(String command) throws IOException, InterruptedException
    {
        System.out.println(command);
        Commander commander = new Commander(command);

        int exitCode = commander.execute();

        StringBuilder sb = new StringBuilder();
        for (String line : commander.getStderr())
        {
            sb.append(line);
            sb.append(System.lineSeparator());
        }            
        System.out.println(sb.toString());
        
        return exitCode;
    }
    
    public List<Boolean> generateDirectionalPngs(Path oscadInputFile, boolean forcePngGeneration)
    {
    	List<Boolean> exitCodes = new ArrayList();

        Stream.of( OpenScadCameraDirections.values() )
		.forEach((v) -> 
		{
		    try 
		    {
				boolean exitCode = generateOneDirectionalPng(oscadInputFile, forcePngGeneration, v);
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
    public boolean generateOneDirectionalPng(Path oscadInputFile, boolean forceGeneration, OpenScadCameraDirections direction)
            throws IOException, InterruptedException
    {
        String openscadPath = "/cygdrive/c/opt/OpenSCAD/openscad-2015.03-1/openscad";

        openscadPath = "C:/opt/OpenSCAD/openscad-2015.03-1/openscad";
        
        openscadPath = "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD";

        String outfileName = DataSetValidator.baselineNameForReal(oscadInputFile, forceGeneration, direction);

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

            int distance = 150;
            String rotateParams = direction.getRotateParams().replaceAll(" ", "");
            String command = openscadPath
                    + " -o " + outfileName + " " + "--camera=0,0,0," + rotateParams + "," + distance + " " + infilePath;
            
            exitCode = generate(command);
        }

        // an exit code of 0 is expected for successful execution of a system command 
        return exitCode == 0;
    }

    public boolean generatePngs(List<Path> openscadPaths, boolean forcePngGeneration) throws IOException,
            InterruptedException
    {
        List<Boolean> exitCodes = new ArrayList();

        openscadPaths.forEach((p) -> 
        {
            List<Boolean> directionalExitCodes = generateDirectionalPngs(p, forcePngGeneration);
            exitCodes.addAll(directionalExitCodes);
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
