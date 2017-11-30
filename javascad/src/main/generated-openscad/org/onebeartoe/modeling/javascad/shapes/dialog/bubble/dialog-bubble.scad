color([0,0,1])difference(){union() {
difference(){scale([1,2,1])cylinder(h=1, r=5, center=true);
scale([1,2,1])cylinder(h=1.02, r=4, center=true);
}translate([6,-3,0])rotate([0,0,-10])cylinder(h=1, r=3, $fn = 3, center=true);
}
translate([4.2,-2.7,-0.01])rotate([0,0,-10])cylinder(h=1.03, r=3, $fn = 3, center=true);
}