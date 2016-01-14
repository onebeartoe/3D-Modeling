
$fn = 100;

openCylinder();

module openCylinder(height = 3)
{    
    difference()
    {
        cylinder(r=7, h=height);
        
        radius = 4.5;
        translate([0, 0, -1])
        cylinder(r=radius, h=height+2);
    }
}