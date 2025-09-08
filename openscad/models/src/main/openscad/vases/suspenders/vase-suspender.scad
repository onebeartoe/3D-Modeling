
module vaseSuspender(height = 3,
              holeCount = 3,
              holeRadius = 1,
              innerRadius = 40,
              outerRadiusThickness = 5)
{
   difference()
    {
        // outer ring
        cylinder(h = height,
                 r = innerRadius + outerRadiusThickness);

        // ring cutout
        translate([0, 0, -0.01])
        cylinder(h = height + 0.02,
                 r = innerRadius);

        // cord holes                 
        for(s = [0 : holeCount])
        {
            angle = s * (360 / holeCount);

            xTranslate = innerRadius + (outerRadiusThickness / 2.0);
            color("blue")
            rotate([0, 0, angle])
            translate([xTranslate, 0, -0.01])
            cylinder(h = 8,
                     r = holeRadius
                     );
        }
    }
}
