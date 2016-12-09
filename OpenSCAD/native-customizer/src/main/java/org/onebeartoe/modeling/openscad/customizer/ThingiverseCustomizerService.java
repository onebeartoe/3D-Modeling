
package org.onebeartoe.modeling.openscad.customizer;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class ThingiverseCustomizerService
{
    /**
     * This method parses an OpenSCAD 'use' line and returns the absolute path to the file
     * specified by use argument.
     * @param useLine
     * @return 
     */
    private String readUseFile(File sourceParent, String useLine) throws IOException
    {
        // take off "use <"
        String rawSubPath = useLine.substring(5);
        
        // take off ">"
        rawSubPath = rawSubPath.substring(0, rawSubPath.length()-1);
        
        String targetPath = sourceParent.getAbsolutePath() + File.separator + rawSubPath;
        File targetFile = new File(targetPath);
                
        String absolutePath = targetFile.getAbsolutePath();
        
        File infile = new File(absolutePath);
        Path inpath = infile.toPath();
        List<String> allLines = Files.readAllLines(inpath);
        String content = String.join(System.lineSeparator(), allLines);
        
        return content;
    }
    
    private String interpolateLine(File sourceParent, String line) throws IOException
    {
        String trimmedLine = line.trim();
        
        String interpolatedLine;
        
        if(trimmedLine.startsWith("use"))
        {
            interpolatedLine = readUseFile(sourceParent, line);
        }
        else
        {
            interpolatedLine = trimmedLine;
        }
                
        return interpolatedLine;
    }
    
    public String interpolateOpenscad(File openscadFile) throws IOException
    {
        StringBuilder sb = new StringBuilder();
        
        Path inpath = openscadFile.toPath();
        
        List<String> openscadLines = Files.readAllLines(inpath);
        
        List<String> errors = new ArrayList();
        
        openscadLines.forEach(line -> 
        {
            try 
            {
                File sourceParent = openscadFile.getParentFile();
                String interpolatedLine = interpolateLine(sourceParent, line);
                sb.append(interpolatedLine);
                sb.append( System.lineSeparator() );
            } 
            catch (IOException ex) 
            {
                errors.add( ex.getMessage() );
                Logger.getLogger(ThingiverseCustomizerService.class.getName()).log(Level.SEVERE, null, ex);
            }
        });
        
        if(errors.size() > 0)
        {
            String message = String.join(System.lineSeparator(), errors);
            
            throw new IOException(message);
        }
        
        return sb.toString();
    }
}
