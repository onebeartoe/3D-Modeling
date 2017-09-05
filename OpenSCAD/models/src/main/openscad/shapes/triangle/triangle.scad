
module triangle(size=1, height=1)
{
    rotate([0, 0, 90])
    cylinder(r=size, 
             $fn=3,
             h=height);
}