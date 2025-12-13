
package org.onebeartoe.modeling.openscad.test.suite;

import java.util.List;

/**
 *
 */
public class TakeTooLongInvestigation 
{
    public static void main(String[] args) 
    {
        var app = new TakeTooLongInvestigation();
        
        app.investigate();
    }

    private void investigate() 
    {
        List<String> starts = loadStarts();
        
        List<String> ends = loadEnds();
        
        var startsCount = starts.size();
        
        var endsCounts = ends.size();
        
        if(endsCounts > startsCount)
        {
            var message = "input error - finished count (%s) cannot be greater than starts count (%s)";
            
            message = String.format(message, endsCounts, startsCount);
            
            throw new UnsupportedOperationException(message);
        }
        
        List<String> missing = missingFrom(starts, ends);
        
        var missingSize = missing.size();
        
        if(missingSize > 0)
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

    private List<String> loadStarts() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private List<String> loadEnds() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private List<String> missingFrom(List<String> starts, List<String> ends) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
