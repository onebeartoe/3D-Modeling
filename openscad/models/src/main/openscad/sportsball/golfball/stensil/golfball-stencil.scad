
use <../../../basics/text/text-extrude/text-extrude.scad>
use <../../../shapes/geometry/arc/extruded/extruded-arc.scad>

diameter = 42.67;
radius = diameter / 2.0;

shellThinness = 3;

ballShellRadius = radius + shellThinness;

difference()
{
    // shell
    sphere(center = true,
                r = ballShellRadius);

    // golfball
    sphere(center = true,
        r = radius
        );

    // bottom cuttoff
    xy = ballShellRadius + 40;
    cubeZ = 30;
    translate([0, 0, -cubeZ / 2.0])
    cube([xy, xy, cubeZ],
            center = true);


    text = "M";
    zTranslate = ballShellRadius - 6;
    color("purple")
    translate([0, 0, zTranslate])
    textExtrude(height = 10,
                text = text,
                textSize = 12);                
//}


arcCount = 3;
for ( i = [0 : arcCount] )
{
    color("orange")
    rotate( i * 360 / (arcCount+1), [0, 0, 1])
    translate([0, 0, 8])
    rectangularArc(radius = 12, 
                    radiusExtension = 2, 
                    angle = 360.0 / arcCount - 45, 
                    height = 15);
}

}
