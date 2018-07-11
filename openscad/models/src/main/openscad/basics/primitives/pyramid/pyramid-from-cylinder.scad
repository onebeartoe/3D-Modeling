
// originally from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#cylinder

color("yellow")
translate([-50, 0, 0])
cylinder(20,20,20, $fn=3);

color("pink")
translate([0, 0, 0])
cylinder(20,20,00, $fn=40);

color("orange")
translate([50, 0, 0])
cylinder(h=20, r1=20, r2=10, $fn=24);

color("blue")
translate([100, 0, 0])
cylinder(h=20, r1=20, r2=10, $fn=4);

color("green")
translate([160, 0, 0])
cylinder(h=20, r1=20, r2=20, $fn=30);

color("red")
translate([220, 0, 0])
cylinder(r=20, h = 60, $fn=3);
