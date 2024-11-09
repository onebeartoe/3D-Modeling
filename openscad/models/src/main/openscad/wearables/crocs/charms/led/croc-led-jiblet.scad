
use </home/roberto/Versioning/owner/github/3D-Modeling/openscad/models/src/main/openscad/basics/rounded-edges/rounded-cube/rounded-cube.scad>;

module blank()
{
    // color("green")
    // import("croc-blank/files/blank.stl", convexity=10);

    // top
    rotate([180,0,0])
    translate([0,0,-4.5])
    jiblet();

    color("pink")
    cylinder(r=5, h=4);

    // bottom 
    rotate([180,0,0])
    translate([0,0,-2])
    jiblet();
}
 
module jiblet()
{
    cone(height = 3, bottomRadius = 6.5, topRadius = 5);
}

module cone(height, bottomRadius, topRadius)
{
    cylinder(h=height, r1=bottomRadius, r2=topRadius, $fn=64);
}

module connector()
{
    translate([0,0,4.4445])
    cylinder(r = 6.6, h = 1.7, $fn = 90);
}

module clip()
{
    difference()
    {
        {
        // color("blue")
        // rotate([180, 0, 0])
        // translate([0,-2,-8])
        // import("cr2032-led-clip/files/_cr2032_Clip_version_3.3.stl", convexity=10); 

        size = [20.8, 4.2, 3];
        color("green")
        rotate([90,0,0])    
        translate([-9.8, 6.4, -2])
        roundedCube(cornerRadius = 2,
                    sides=15,
                    sidesOnly=true,
                    size=size);    
        }

        clipCutouts();
    }
}

module clipCutouts()
{
    translate([-10.2, -4, 6.2])
    cube([20.5,10,3.3]);

    // diagnal cutout
    rotate([0, -80, 0])
    translate([8, 0, -20])
    cylinder(r = 1, h = 50, $fn = 90);

    translate([10.5, 0, 6])
    cylinder(r = 1, h = 15, $fn = 90);
}

module cutout_clip()
{
    // color("blue")
    // rotate([180, 0, 0])
    // translate([0,-2,-8])
    // import("cr2032-led-clip/files/_cr2032_Clip_version_3.3.stl", convexity=10);    

    color("purple")
    translate([0,0,9.5])
    cube(size=[15,3.9,10], center=true);

}
