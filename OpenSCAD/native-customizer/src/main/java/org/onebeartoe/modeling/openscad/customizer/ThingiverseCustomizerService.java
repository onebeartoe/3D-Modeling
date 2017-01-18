
package org.onebeartoe.modeling.openscad.customizer;

import java.io.File;
import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.InvalidPathException;
import java.nio.file.Path;

import java.util.ArrayList;
import java.util.List;

public class ThingiverseCustomizerService
{   
    private boolean isUseStatement(String line)
    {
        String trimmedLine = line.trim();
        
        boolean isUseStatement = false;
        
        if(trimmedLine.startsWith("use"))
        {
            isUseStatement = true;
        }
                
        return isUseStatement;
    }
    
    public String interpolateOpenScad(File targetScadFile) throws IOException
    {
        OpenScadParse initialOpenScadParse = readOpenScadFile(targetScadFile);
        
        List<String> uniqueUseStatements = new ArrayList();
        uniqueUseStatements.addAll(initialOpenScadParse.useStatements);
        
        List<String> unprocessedUseStatements = new ArrayList();
        unprocessedUseStatements.addAll(uniqueUseStatements);
        
        List<String> useStatementsContent = new ArrayList();
        
        while( !unprocessedUseStatements.isEmpty() )
        {
            String useStatement = unprocessedUseStatements.remove(0);
            
            File targetParentDir = targetScadFile.getParentFile();
            String absolutePath = absolutePathOf(targetParentDir, useStatement);
            
            if( !uniqueUseStatements.contains(absolutePath) )
            {
                uniqueUseStatements.add(absolutePath);
                
                File infile = new File(absolutePath);
                OpenScadParse currentParse = readOpenScadFile(infile);
                
                unprocessedUseStatements.addAll(currentParse.useStatements);
                
                useStatementsContent.addAll(currentParse.otherStatements);
            }
        }
        
        List<String> finalOutput = new ArrayList();
        finalOutput.addAll(initialOpenScadParse.otherStatements);
	finalOutput.addAll(useStatementsContent);
                
        String content = String.join(System.lineSeparator(), finalOutput);
        
        return content;
    }
    
    /**
     * This method parses an OpenSCAD 'use' line and returns the absolute path to the file
     * specified by use argument.
     * 
     * @param useLine
     * @return 
     */
    private String absolutePathOf(File targetParentDir, String useLine) throws IOException
    {
        // take off "use <"
        String rawSubPath = useLine.substring(5);
        
        // take off ">" or ">;"
        int subtract = rawSubPath.endsWith(";") ? 2 : 1;
        int endIndex = rawSubPath.length() - subtract;
        rawSubPath = rawSubPath.substring(0, endIndex);
        
        String targetPath = targetParentDir.getAbsolutePath() + File.separator + rawSubPath;
        File targetFile = new File(targetPath);
                
        String absolutePath = targetFile.getAbsolutePath();
        
        return absolutePath;
    }
    
    private OpenScadParse readOpenScadFile(File infile) throws IOException
    {
        OpenScadParse parse = new OpenScadParse();
        
        Path inpath;
        try
        {
            inpath = infile.toPath();
        }
        catch(InvalidPathException e)
        {
            throw new IOException("The parser currently does not support absolute paths like: " + infile.getPath(), e);
        }
        
        List<String> openscadLines = Files.readAllLines(inpath);

        openscadLines.forEach(line -> 
        {            
            // separate the use statements and non-use statements
            if( isUseStatement(line) )
            {
                parse.useStatements.add(line);
            }
            else
            {
                parse.otherStatements.add(line);
            }
        });        
        
        return parse;
    }
    
    private class OpenScadParse
    {
        public List<String> useStatements;
        
        public List<String> otherStatements;
        
        public OpenScadParse()
        {
            useStatements = new ArrayList();
            otherStatements = new ArrayList();
        }
    }
}