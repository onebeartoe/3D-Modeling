package org.onebeartoe.modeling.openscad.test.suite;

import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.util.List;

public class OpenScadTestSuite
{

    public static void main(String[] args) throws Throwable
    {
        System.out.println("Welcome to the onebeartoe OpenSCAD test suite.");
        OpenScadFileFinder openScadFinder = new OpenScadFileFinder();
        String path = "C:\\home\\owner\\versioning\\github\\3D-Modeling\\OpenSCAD";
        Path inpath = FileSystems.getDefault().getPath(path);
        List<Path> openscadPaths = openScadFinder.getFiles(inpath);

//        openscadPaths.forEach((p) -> System.out.println(p));

        DataSetValidator inputValidator = new DataSetValidator();
        List<String> missingPngs = inputValidator.validate(openscadPaths);
        
        if( !missingPngs.isEmpty() )
        {
            System.err.println("The test suite will not continue with missing baseline PNG images.");
        }
        else
        {
            System.out.println("the test continues...");
        }
    }
}
