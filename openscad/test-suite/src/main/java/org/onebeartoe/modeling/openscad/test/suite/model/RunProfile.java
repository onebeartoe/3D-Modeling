
package org.onebeartoe.modeling.openscad.test.suite.model;

import java.nio.file.Path;
import java.util.List;
import org.onebeartoe.modeling.openscad.test.suite.OpenScadCliTestSuite;

/**
 * @author Roberto Marquez <https://www.youtube.com/user/onebeartoe>
 */
public class RunProfile 
{
    public boolean deleteProposedBaseLines;
    
    public boolean diffOnly;
    
    public boolean generateBaselines;
    
    public boolean redirectOpenscad;
    
    public String path;
    
    public boolean singleScadWithDependenciesMode;
    
    public List<Path> openscadPaths;
    
    public String executablePath;
    
    public OpenScadCliTestSuite.RunMode mode;
}
