
module triangle(size, height)
{
    rotate([0, 0, 90])
    cylinder(r=size, 
             $fn=3,
             h=height);
}