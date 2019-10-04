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
    
    private boolean viewall;

    public DirectoryProfile()
    {
        viewall = true;
    }
    
    public Path getPath()
    {
        return path;
    }

    public boolean viewall()
    {
        return viewall;
    }
    
    public void setViewall(boolean viewall)
    {
        this.viewall = viewall;
    }

    public void setPath(Path path)
    {
        this.path = path;
    }
}
