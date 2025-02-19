
module flashlightHolder(extendoLengthX = 35,
                        flashlightRadius = 9,
                        roundiness = 90,
                        showFlashlight = false,
                        yLength = 30)
{
    basketAttachment(yLength = yLength);

    // extendo
    color("blue")
    cube([extendoLengthX, yLength, 5]);

    // flashlight holder and cutout
    holderLength_z = 50;
    cutoutTranslate_y = yLength / 2.0;
    cutoutTranslate_z = holderLength_z - flashlightRadius - 10;
    flashlightTranslate = [0, cutoutTranslate_y, cutoutTranslate_z];    
    flashlightCutoutHolder(extendoLengthX = extendoLengthX,
                            flashlightTranslate = flashlightTranslate,
                           flashlightRadius = flashlightRadius,
                           holderLength_z = holderLength_z,
                           length_z_SUS = holderLength_z, 
                           roundiness = roundiness,
                           yLength = yLength);

    // flashlight
    if(showFlashlight)
    {
        flashlight(radius = flashlightRadius, 
                   roundiness = roundiness,
                   translate = flashlightTranslate);
    }
}

module basketAttachment(yLength)
{
    difference()
    {
        xLength = 15;
        zLength = 22;
        color("black")
        cube([xLength, yLength, zLength]);    

        cutoutLength = yLength + 5 * 2;
        xTranslate = xLength * 0.5;
        yTranslate = cutoutLength - 5;
        zTranslate = zLength * 0.5;
        color("green")
        translate([xTranslate, yTranslate, zTranslate])
        rotate([90, 0,0])
        cylinder(r = 4, h = cutoutLength, $fn = 60);       
    }
}

module flashlight(radius, roundiness, translate)
{
    diameter = 21; // this was measured

    length = 91;   // this was measured

    extendedLength = 102;  // this was measured

    translate(translate)
    rotate([0,90,0])
    %cylinder(r = radius, h = length, $fn = roundiness);
}

module flashlightCutoutHolder(extendoLengthX, 
                                flashlightRadius,
                                flashlightTranslate,
                                holderLength_z, 
                                length_z_SUS, 
                                roundiness,
                                yLength
)
{
    color("pink")
    translate([extendoLengthX,0,0])
    cube([5, yLength, holderLength_z]);

    // flashlight cutout
    color("green")
    translate(flashlightTranslate)    
    rotate([0,90,0])
    cylinder(r = flashlightRadius, h = 69, $fn = roundiness);
}
