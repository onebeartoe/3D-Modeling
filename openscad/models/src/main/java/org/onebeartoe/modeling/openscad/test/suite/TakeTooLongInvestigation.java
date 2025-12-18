
package org.onebeartoe.modeling.openscad.test.suite;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

/**
 *
 */
public class TakeTooLongInvestigation 
{
    public static void main(String[] args) throws IOException 
    {
        var app = new TakeTooLongInvestigation();
        
        app.investigate();
    }

    private void investigate() throws IOException 
    {
        List<String> starts = loadStarts();
        
        List<String> ends = loadFinishes();
        
        var startsCount = starts.size();
        
        var endsCounts = ends.size();
        
        if(endsCounts > startsCount)
        {
            var message = "input error - finished count (%s) cannot be greater than starts count (%s)";
            
            message = String.format(message, endsCounts, startsCount);
            
            throw new UnsupportedOperationException(message);
        }
        else if( startsCount != endsCounts)
        {
            var count = startsCount - endsCounts;
            
            System.out.println("difference count = " + count);
        }
        
        List<String> missing = missingFrom(starts, ends);
        
        var missingSize = missing.size();
        
        if(missingSize == 0)
        {
            System.out.println("All are present.");
        }
        else
        {
            var title = "The following finishes are missing:";
            
            System.out.println("title = " + title);   
            
            missing.forEach(m ->
            {
                System.out.println("m = " + m);
            });                    
        }
    }

    private List<String> loadStarts() throws IOException 
    {
        var inpath = "target/png.starts";
        
        var path = Path.of(inpath);
        
        List<String> allLines = Files.readAllLines(path);
        
        return allLines;
    }

    private List<String> loadFinishes() throws IOException 
    {
        var inpath = "target/png.finishes";
                
        var path = Path.of(inpath);
        
        return Files.readAllLines(path);
    }

    private List<String> missingFrom(List<String> starts, List<String> finishes) 
    {
        var missing = new ArrayList<String>(starts);
        
        System.out.println("missingFrom() - starts count: " + starts.size() + 
                " finishes count: " + finishes.size() );
        
        missing.removeAll(finishes);
        
        System.out.println("missingFrom() - missing count: " + missing.size() );
        
        return missing;
    }
}
