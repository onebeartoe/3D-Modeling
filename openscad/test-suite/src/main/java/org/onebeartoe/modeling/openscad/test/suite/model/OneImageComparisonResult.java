
package org.onebeartoe.modeling.openscad.test.suite.model;

import java.time.Duration;

/**
 * This class represents one image comparison result. 
 */
public class OneImageComparisonResult
{    
    private String file;
    
    private Duration duration;

    public String getFile()
    {
        return file;
    }

    public void setFile(String file)
    {
        this.file = file;
    }

    public Duration getDuration()
    {
        return duration;
    }

    public void setDuration(Duration duration)
    {
        this.duration = duration;
    }
    
    @Override
    public String toString()
    {
        return String.format("%s.%s - %s", duration.getSeconds(), duration.getNano(), file);
    }
}
