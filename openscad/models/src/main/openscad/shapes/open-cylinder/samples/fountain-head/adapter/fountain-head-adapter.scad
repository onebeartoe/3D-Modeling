
use <../../../open-cylinder.scad>

innerDiameter = 11.0; // very slightly loose
innerRadius = innerDiameter / 2.0;

outerDiameter = 14.5; // very slightly snug
outerRadius = outerDiameter / 2.0;

openCylinder(height = 18,
                    outerRadius = outerRadius,
                    innerRadius = innerRadius);
