package org.onebeartoe.modeling.openscad.test.suite;

import java.io.IOException;
import java.nio.file.DirectoryIteratorException;
import java.nio.file.DirectoryStream;
import java.nio.file.FileVisitResult;
import static java.nio.file.FileVisitResult.;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.List;

public class OpenScadFileFinder
{
    public List<Path> find(Path inpath) throws Throwable
    {
        System.out.println("finding files under: " + inpath);
        List<Path> openscadPaths = new ArrayList<>();
        try (DirectoryStream<Path> stream = Files.newDirectoryStream(inpath))
        //, "*.{scad,SCAD}"))
        {
            for (Path entry : stream)
            {
                //                System.out.println("found: " + entry);
                openscadPaths.add(entry);
            }
        }
        catch (IOException | DirectoryIteratorException ex)
        {
            // I/O error encounted during the iteration, the cause is an IOException
            throw ex.getCause();
        }

        return openscadPaths;
    }

    private class PrintFiles extends SimpleFileVisitor<Path>
    {
        // Print information about
        // each type of file.
        @Override
        public FileVisitResult visitFile(Path file, BasicFileAttributes attr)
        {
            if (attr.isSymbolicLink())
            {
                System.out.format("Symbolic link: %s ", file);
            }
            else if (attr.isRegularFile())
            {
                System.out.format("Regular file: %s ", file);
            }
            else
            {
                System.out.format("Other: %s ", file);
            }
            System.out.println("(" + attr.size() + "bytes)");
            return CONTINUE;
        }
    }
}
