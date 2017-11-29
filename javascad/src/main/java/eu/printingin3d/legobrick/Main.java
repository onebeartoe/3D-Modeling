package eu.printingin3d.legobrick;

import java.io.File;
import java.io.IOException;

import eu.printingin3d.javascad.exceptions.IllegalValueException;
import eu.printingin3d.javascad.utils.SaveScadFiles;

public class Main 
{
    protected String outputPath = "target/outscad/";
    
    /**
     * @param args
     * @throws IOException 
     * @throws IllegalValueException 
     */
    public static void main(String[] args) throws IllegalValueException, IOException 
    {
        Main test = new Main();
        File outDir = new File(test.outputPath);
        String outFilename = "lego_brick.scad";
        new SaveScadFiles(outDir).
            addModel(outFilename,  new LegoBrick(1, 6)).
            saveScadFiles();
    }
}
