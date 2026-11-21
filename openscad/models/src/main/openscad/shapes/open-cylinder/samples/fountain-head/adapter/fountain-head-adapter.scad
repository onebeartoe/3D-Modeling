
use <../../../open-cylinder.scad>

innerDiameter = 10.0;
innerRadius = innerDiameter / 2.0;

outerDiameter = 14.0;
outerRadius = outerDiameter / 2.0;

openCylinder(height = 18,
                    outerRadius = outerRadius,
                    innerRadius = innerRadius);
