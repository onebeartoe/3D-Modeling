
use <../../../../shapes/oval/oval.scad>


module triantleReflectorMount()
{
   difference()
    {
        height = 1;
        color("blue")
        // oval(height = height,
		// 	radius = 80,
        //     xScale = 1.2,
        //     yScale = 1.4);

        union()
        {   
            cube(size = [110, 20, height], center = true);

            translate([0, 0, 0])
            cube(size = [20, 190, height], center = true);
        }

        horizontalCutouts();
    
        verticleCutouts();
    }

    module horizontalCutouts()
    {
        translate = 42;

        translate([translate, 0, 0])
        cylinder(h = 6, r = 5, center = true);

        translate([-translate, 0,0])
        cylinder(h = 6, r = 5, center = true);
    }   

    module verticleCutouts()
    {
        translate = 76;

        translate([0, translate, 0])
        cylinder(h = 6, r = 5, center = true);

        translate([0, -translate, 0])
        cylinder(h = 6, r = 5, center = true);
    }   
}


