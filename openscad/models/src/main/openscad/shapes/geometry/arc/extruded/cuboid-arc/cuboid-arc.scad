
use <../extruded-arc.scad>

radius = 20;
radiusExtension = 2;
angle = 111;
height = 10;

color("orange")
rectangularArc(radius = radius, 
               radiusExtension = radiusExtension, 
               angle = angle, 
               height = height);


color("blue")
rotate([0, 0, 135])
rectangularArc(radius = radius, 
               radiusExtension = radiusExtension, 
               angle = -angle, 
               height = height);
