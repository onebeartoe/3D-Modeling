package org.onebeartoe.modeling.openscad.test.suite.model;

/**
 * @author Roberto Marquez
 */
public class GlobalVariables
{
    static
    {
        System.out.println("Global variables are initialized.");
    }

    public static final String BASELINE_SUFFIX = "-baseline.png";

    public static final String OPENSCAD_FILE_PATTERN = "*.scad";
}
