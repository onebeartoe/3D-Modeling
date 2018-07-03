/*
 */
package org.onebeartoe.modeling.openscad.test.suite.utils;

import java.nio.file.Path;

/**
 *
 * @author Roberto Marquez
 */
class DirectoryProfile
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

    void setPath(Path path)
    {
        this.path = path;
    }
}
