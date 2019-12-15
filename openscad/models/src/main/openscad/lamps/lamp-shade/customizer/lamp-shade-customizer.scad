
outerRadius = 15;       // [10 : 60]
squareLength = 20;      // [10 : 30]
xScale = 0.5;           // [0.1 : 0.1 : 2.0]
yScale = 0.7;           // [0.1 : 0.1 : 2.0]

use <../lamp-shade.scad>

lampShade(outerRadius = outerRadius,
          squareLength = squareLength,
          xScale = xScale,
          yScale = yScale);
