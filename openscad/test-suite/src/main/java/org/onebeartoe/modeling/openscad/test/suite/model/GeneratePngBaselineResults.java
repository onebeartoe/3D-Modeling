
package org.onebeartoe.modeling.openscad.test.suite.model;

import java.nio.file.Path;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author lando
 */
public class GeneratePngBaselineResults 
{
    private boolean success;
    
    private final Map<Path, Duration> pathDurations;

    public GeneratePngBaselineResults()
    {
        pathDurations = new HashMap();
    }
    
    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public void addPathDuration(Path path, Duration duration)
    {
        pathDurations.put(path, duration);
    }

    public Map<Path, Duration> getPathDurations() 
    {
        return pathDurations;
    }
}
