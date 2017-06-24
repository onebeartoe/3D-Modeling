
use <../../../triangle/triangle.scad>

starOfDavid();

module starOfDavid()
{
    height = 3;
    
    union()
    {
        triangle(height = height);
        
        rotate([0, 0, 180])
        color("green")
        triangle(height = height);
    }
}
