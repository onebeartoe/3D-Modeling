
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OpenScadTestSuite
{
    private List<Path> openscadPaths;
    
    private PngGenerator pngGenerator;
    
    public OpenScadTestSuite()
    {
	pngGenerator = new PngGenerator();
    }

    public void generateBaselines() throws IOException, InterruptedException
    {
        System.out.println("test suite generating baselines, count: " + openscadPaths.size());

        // don't overwrite any existing baseline images
        boolean forcePngGeneration = false;
        
        pngGenerator.generatePngs(openscadPaths, forcePngGeneration);
    }

    public void generateProposedBaselines() throws IOException, InterruptedException
    {
        // create the proposed baseline images every time the test suite is run
        boolean forcePngGeneration = true;
        
        pngGenerator.generatePngs(openscadPaths, forcePngGeneration);	
    }
    
    public static void main(String[] args) throws Throwable
    {
        if (args.length == 0)
        {
            printHelp();
        }
        else
        {
            OpenScadTestSuite testSuite = new OpenScadTestSuite();
            testSuite.serviceRequest(args);
        }
    }

    private static void printHelp() throws URISyntaxException, IOException
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

    public void run(String[] args) throws Throwable
    {
        System.out.println("Welcome to the onebeartoe OpenSCAD test suite.");

        DataSetValidator inputValidator = new DataSetValidator();
        List<String> missingPngs = inputValidator.validate(openscadPaths);

        if (!missingPngs.isEmpty())
        {
            System.err.println("The test suite will not continue with missing baseline PNG images.");
        }
        else
        {
            System.out.println("Generating a proposed version of the .png  from each .oscad file...");

            generateProposedBaselines();
            
            System.out.println("The proposed baseline files are generated.");
            
            System.out.println("Comparing baseline images to the proposed baseline images...");
            
            
        }
    }

    public void serviceRequest(String[] args) throws Throwable
    {
        String path;

        if (args.length > 1)
        {
            // a parameter besides the path was given, presumably for baseline generation
            path = args[1];
        }
        else
        {
            // assume the request is to run the test suite
            path = args[0];
        }

        OpenScadFileFinder openScadFinder = new OpenScadFileFinder();
        Path inpath = FileSystems.getDefault().getPath(path);
        openscadPaths = openScadFinder.getFiles(inpath);

        if (args.length > 1)
        {
            if (args[0].equals("--generateBaselines"))
            {
                generateBaselines();
            }
            else
            {
                System.err.println("An unknown parameter was encountered: " + args[0]);
                printHelp();
            }
        }
        else
        {
            run(args);
        }
    }
}
