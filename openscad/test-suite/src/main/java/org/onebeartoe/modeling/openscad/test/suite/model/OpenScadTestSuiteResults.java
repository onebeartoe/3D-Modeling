
package org.onebeartoe.modeling.openscad.test.suite.model;

/**
 * This class holds results for PNG generation and comparison.
 */
public class OpenScadTestSuiteResults 
{
    private ImageComparisonResult compareResults;
    
    private GeneratePngBaselineResults pngGenerationResults;

    public ImageComparisonResult getCompareResults() {
        return compareResults;
    }

    public void setCompareResults(ImageComparisonResult compareResults) {
        this.compareResults = compareResults;
    }

    public GeneratePngBaselineResults getPngGenerationResults() {
        return pngGenerationResults;
    }

    public void setPngGenerationResults(GeneratePngBaselineResults pngGenerationResults) {
        this.pngGenerationResults = pngGenerationResults;
    }
}
