use <../light-signal-test.scad>

difference()
{
    union() 
    {
        translate([0,0,-1])
        openCylinder(height=35, innerRadius=18.5, outerRadius=21.0);

        color([0,1,0])
        cylinder(h=2, r=18.6, center=true);
    }

    cube([5,5,5],center=true);
}
