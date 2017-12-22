package org.onebeartoe.modeling.openscad.test.suite;

/**
 * @author Roberto Marquez
 */
public class GlobalVariables
{
    static
    {
        System.out.println("Global variables are initialized.");
    }

    public static final String baselineSuffix = "-baseline.png";

//    public static final String proposedBaselineSuffix = "-proposed" + baselineSuffix;

    public static final String OPENSCAD_FILE_PATTERN = "*.scad";
}
