

use <../../../../../shapes/open-cylinder/open-cylinder.scad>

fastenerThickness = 3;

cylinder(r = 5, h = 10);

height = 9;
innerRadius = 9;
outerRadius = 19;


openCylinder(height = height,
            innerRadius = innerRadius,
            outerRadius = outerRadius);
