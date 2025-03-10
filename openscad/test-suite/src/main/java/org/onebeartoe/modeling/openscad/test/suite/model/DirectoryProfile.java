/*
 */
package org.onebeartoe.modeling.openscad.test.suite.model;

import java.nio.file.Path;

/**
 *
 * @author Roberto Marquez
 */
public class DirectoryProfile
{
    private Path path;

    private boolean autoCenter;
    
    private boolean viewall;
    
    private boolean skipPngGeneration;

    public DirectoryProfile()
    {
        viewall = true;
    }

    public boolean autoCenter()
    {
        return autoCenter;
    }
    
    public Path getPath()
    {
        return path;
    }

    public boolean getSkipPngGeneration() 
    {
        return skipPngGeneration;
    }    
    public boolean viewall()
    {
        return viewall;
    }
    
    public void setAutoCenter(boolean autoCenter)
    {
        this.autoCenter = autoCenter;
    }
    public void setViewall(boolean viewall)
    {
        this.viewall = viewall;
    }

    public void setPath(Path path)
    {
        this.path = path;
    }

    public void setSkipPngGeneration(boolean skipPngGeneration) 
    {
        this.skipPngGeneration = skipPngGeneration;
    }
}
