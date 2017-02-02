
package org.onebeartoe.modeling.opensacd.services;

import java.io.File;
import java.io.IOException;

import java.nio.file.Files;
import java.nio.file.InvalidPathException;
import java.nio.file.Path;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ThingiverseCustomizerService
{   
    private Logger logger;
    
    public ThingiverseCustomizerService()
    {
        logger = Logger.getLogger( getClass().getName() );
    }
    
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
        
        List<String> unprocessedUseStatements = new ArrayList();
        unprocessedUseStatements.addAll(initialOpenScadParse.useStatements);
        
        List<String> useStatementsContent = new ArrayList();
        
        while( !unprocessedUseStatements.isEmpty() )
        {
            String useStatement = unprocessedUseStatements.remove(0);
                        
            if( !uniqueUseStatements.contains(useStatement) )
            {
                uniqueUseStatements.add(useStatement);
                
                File infile = new File(useStatement);
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
        String rawSubPath = useLine.trim();
        rawSubPath = rawSubPath.substring(5);
        
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
                File targetParentDir = infile.getParentFile();
                String absolutePath;
                try 
                {
                    absolutePath = absolutePathOf(targetParentDir, line);
                } 
                catch (IOException ex) 
                {
                    absolutePath = "unable to process: " + line;
                    
                    String message = absolutePath;
                    logger.log(Level.SEVERE, message, ex);
                }
            
                parse.useStatements.add(absolutePath);
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