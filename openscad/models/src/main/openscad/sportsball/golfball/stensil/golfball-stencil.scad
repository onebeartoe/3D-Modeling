
use <../../../basics/text/text-extrude/text-extrude.scad>
use <../../../shapes/geometry/arc/extruded/extruded-arc.scad>

ballDiameter = 42.67;
ballRadius = ballDiameter / 2.0;

shellThinness = 3;

ballShellRadius = ballRadius + shellThinness;

difference()
{
    // shell
    sphere(center = true,
                r = ballShellRadius);

    // golfball cutout
//    cutoutRadius = ballRadius + 1;
    cutoutRadius = ballRadius + 0.5;
    sphere(center = true,
        r = cutoutRadius
        );

    // bottom cuttoff
    xy = ballShellRadius + 40;
    cubeZ = 30;
    translate([0, 0, -cubeZ / 2.0])
    cube([xy, xy, cubeZ],
            center = true);


    text = "C";
    zTranslate = ballShellRadius - 6;
    font = "Bauhaus 93:style=Regular";
    color("purple")
    translate([0, 0, zTranslate])
    textExtrude(font = font,
                height = 10,
                text = text,
                textSize = 16);                
//}


arcCount = 3;
for ( i = [0 : arcCount] )
{
    color("orange")
    rotate( i * 360 / (arcCount+1), [0, 0, 1])
    translate([0, 0, 8])
    rectangularArc(radius = 12, 
                    radiusExtension = 3, 
                    angle = 360.0 / arcCount - 45, 
                    height = 15);
}

}
