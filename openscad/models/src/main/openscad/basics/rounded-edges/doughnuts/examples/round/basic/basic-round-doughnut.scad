
use <../../../doughnuts.scad>

roundDoughnut();

// skinny tall
xTranslate = 30;
minkowskiSphereRadius = 0.5;
color("orange")
translate([xTranslate, 0, 0])
roundDoughnut(height = 19,
            innerRadius = 4.6,
            outerRadius = 5.5,
            minkowskiSphereRadius = minkowskiSphereRadius);
