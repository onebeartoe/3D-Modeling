package org.onebeartoe.modeling.openscad.test.suite;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.onebeartoe.system.Commander;

public class PngGenerator
{
    Logger logger;

    public PngGenerator()
    {
        String className = getClass().getName();
        logger = Logger.getLogger(className);
    }

    public boolean generateOnePng(Path oscadInputFile, boolean forceGeneration, RenderViews direction)
            throws IOException, InterruptedException
    {
        String openscadPath = "/cygdrive/c/opt/OpenSCAD/openscad-2015.03-1/openscad";

        openscadPath = "C:/opt/OpenSCAD/openscad-2015.03-1/openscad";

        String outfileName = DataSetValidator.baselineNameFor(oscadInputFile, direction);

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

            String command = openscadPath
            // bottom view
                    + " -o " + outfileName + " " + "--camera=0,0,0,180,0,0,150" + " " + infilePath;

            System.out.println(command);
            Commander commander = new Commander(command);

            exitCode = commander.execute();

            StringBuilder sb = new StringBuilder();
            for (String line : commander.getStderr())
            {
                sb.append(line);
                sb.append(System.lineSeparator());
            }
            logger.log(Level.SEVERE, sb.toString());

        }

        // an exit code of 0 is expected for successful execution of a system command 
        return exitCode == 0;
    }

    public boolean generatePngs(List<Path> openscadPaths, boolean forcePngGeneration) throws IOException,
            InterruptedException
    {
        List<Boolean> exitCodes = new ArrayList();

        openscadPaths.forEach((p) -> {
            boolean exitCode;
            try
            {
                exitCode = generateOnePng(p, forcePngGeneration, RenderViews.BOTTTOM);
                exitCodes.add(exitCode);
            }
            catch (Exception e)
            {
                e.printStackTrace();
            }
        });

        boolean masterExitCode = true;

        for (Boolean ec : exitCodes)
        {
            if (!ec)
            {
                masterExitCode = false;
                break;
            }
        }

        return masterExitCode;
    }
}
