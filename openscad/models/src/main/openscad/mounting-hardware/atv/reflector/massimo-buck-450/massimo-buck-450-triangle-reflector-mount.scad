
use <../../../../shapes/oval/oval.scad>

use <../../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

module triantleReflectorMount()
{
   difference()
    {
        height = 5;

        color("blue")
        // oval(height = height,
		// 	radius = 80,
        //     xScale = 1.2,
        //     yScale = 1.4);

        union()
        {   
//            cube(size = [110, 20, height], center = true);
            roundedCube(cornerRadius = 5,
                                    cubeCentered = true,
                                    sides=20,
                                    sidesOnly=true,
                                    size=[105,20,height]);

            translate([0, 0, 0])
//            cube(size = [20, 190, height], center = true);
            roundedCube(cornerRadius = 5,
                        cubeCentered = true,
                        sides=20,
                        sidesOnly=true,
                        size=[20,185,height]);
        }
  
        cutoutRadius = 6;

        horizontalCutouts(cutoutRadius = cutoutRadius);
    
        verticleCutouts(cutoutRadius = cutoutRadius);
    }

    module horizontalCutouts(cutoutRadius)
    {
        translate = 42;

        translate([translate, 0, 0])
        cylinder(h = 8, r = cutoutRadius, center = true);

        translate([-translate, 0,0])
        cylinder(h = 8, r = cutoutRadius, center = true);
    }   

    module verticleCutouts(cutoutRadius)
    {
        translate = 77;


        translate([0, translate, 0])
        cylinder(h = 8, r = cutoutRadius, center = true);

        translate([0, -translate, 0])
        cylinder(h = 8, r = cutoutRadius, center = true);
    }   
}


