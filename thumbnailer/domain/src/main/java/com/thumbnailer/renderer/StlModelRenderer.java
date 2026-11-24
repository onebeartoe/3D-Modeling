package com.thumbnailer.renderer;

import java.awt.Color;

/**
 * Backwards-compatible STL renderer alias that delegates to {@link TopDownModelRenderer}.
 */
public class StlModelRenderer extends TopDownModelRenderer {

    public StlModelRenderer() {
        super();
    }

    public StlModelRenderer(int width, int height, double marginRatio, Color modelColor, Color backgroundColor, boolean antiAliasing) {
        super(width, height, marginRatio, modelColor, backgroundColor, antiAliasing);
    }
}
