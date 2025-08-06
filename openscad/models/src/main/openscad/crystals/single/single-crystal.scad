

module singleCrystal(bottomRadius = 30, 
                     height = 80,
                     sides = 6,
                     topRadius = 20)
{
    color("orange")
    cylinder(h=height, 
             r1=bottomRadius, 
             r2=topRadius, 
             $fn=sides);

    color("green")
   translate([100, 0, 0])
    cylinder(h=height * 0.4, 
             r1 = topRadius, 
             r2 = 1, 
             $fn=sides);             
}
