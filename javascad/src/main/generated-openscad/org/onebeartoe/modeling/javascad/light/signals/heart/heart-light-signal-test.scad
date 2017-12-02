use <../light-signal-test.scad>

union() 
{
    translate([0,0,-1])
    difference()
    {
//        scale([1,2,1])
        cylinder(h=35, r=5, center=true);

//        scale([1,2,1])
//        cylinder(h=35.02, r=1, center=true);
    }

//    color([0,1,0])
//    cylinder(h=2, r=18.6, center=true);
}
