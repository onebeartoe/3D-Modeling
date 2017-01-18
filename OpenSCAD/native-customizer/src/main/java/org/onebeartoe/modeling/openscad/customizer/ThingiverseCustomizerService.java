
package org.onebeartoe.modeling.openscad.customizer;

import java.io.File;
import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.Path;

import java.util.ArrayList;
import java.util.List;

public class ThingiverseCustomizerService
{
    /**
     * This method parses an OpenSCAD 'use' line and returns the absolute path to the file
     * specified by use argument.
     * 
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
    
    private boolean isUseStatement(File sourceParent, String line) throws IOException
    {
        String trimmedLine = line.trim();
        
        boolean isUseStatement = false;
        
        if(trimmedLine.startsWith("use"))
        {
            isUseStatement = true;
        }
                
        return isUseStatement;
    }
    
    public String interpolateOpenscad(File openscadFile) throws IOException
    {
        StringBuilder sb = new StringBuilder();
        
        Path inpath = openscadFile.toPath();
        
        List<String> openscadLines = Files.readAllLines(inpath);
        
        List<String> errors = new ArrayList();
        
        List<String> initialUseStatements = new ArrayList();
        List<String> coreNonUseStatments = new ArrayList();
        
        openscadLines.forEach(line -> 
        {
            File sourceParent = openscadFile.getParentFile();
            
            // separate the use statements and non-use statements
            if( isUseStatement(sourceParent, line) )
            {
                initialUseStatements.add(line);
            }
            else
            {
                coreNonUseStatments.add(line);
            }
        });
        
        

        String interpolatedLine = interpolateLine(sourceParent, line);
        
        if(errors.size() > 0)
        {
            String message = String.join(System.lineSeparator(), errors);
            
            throw new IOException(message);
        }
        
        return sb.toString();
    }
    
    private class UseStatementParsing
    {
        public List<String> useStatements;
        
        public List<String> nonUseStatements;
        
        public UseStatementParsing()
        {
            useStatements = new ArrayList();
            nonUseStatements = new ArrayList();
        }
    }
}