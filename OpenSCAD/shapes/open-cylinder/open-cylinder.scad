
openCylinder();

module openCylinder(height = 3,
                    outerRadius = 7,
                    innerRadius = 4.5,
                    fn = 100)
{
    $fn = fn;
        
    difference()
    {
        cylinder(r=outerRadius,
                 h=height);
        
        
        translate([0, 0, -1])
        cylinder(r=innerRadius,
                 h=height+1.01);
    }
}
