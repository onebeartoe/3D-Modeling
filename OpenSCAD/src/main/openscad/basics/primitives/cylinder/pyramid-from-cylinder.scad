
// originally from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#cylinder

translate([-50, 0, 0])
cylinder(20,20,20, $fn=3);

color("brown")
cylinder(20,20,00, $fn=4);

color("green")
translate([50, 0, 0])
cylinder(20,20,10, $fn=4);
