
module flashlightHolder(basketAttachment_zLength = 22,
                        extendoLengthX = 35,
                        flashlightRadius = 9.5,
                        roundiness = 90,
                        showFlashlight = false,
                        yLength = 30,
                        zLengthTranslate = 0.5)
{
    holderLength_z = 50;
    cutoutTranslate_y = yLength / 2.0;
    cutoutTranslate_z = holderLength_z - flashlightRadius - 10;
    flashlightTranslate = [-0.01, cutoutTranslate_y, cutoutTranslate_z];

    difference()
    {
        flashlightHolder_core(basketAttachment_zLength = basketAttachment_zLength,
                        cutoutTranslate_y = cutoutTranslate_y,
                        cutoutTranslate_z = cutoutTranslate_z,
                        extendoLengthX = extendoLengthX,
                        flashlightRadius = flashlightRadius,
                        flashlightTranslate = flashlightTranslate,
                        holderLength_z = holderLength_z,
                        roundiness = roundiness,
                        showFlashlight = showFlashlight,
                        yLength = yLength,
                        zLengthTranslate = zLengthTranslate);

        // flashlight cutout
        color("green")
        translate(flashlightTranslate)    
        rotate([0,90,0])
        cylinder(r = flashlightRadius, h = extendoLengthX + 9, $fn = roundiness);                        
    }

    // flashlight
    if(showFlashlight)
    {
        flashlight(radius = flashlightRadius, 
                   roundiness = roundiness,
                   translate = flashlightTranslate);
    }

}

module flashlightHolder_core(basketAttachment_zLength,
                        cutoutTranslate_y,
                        cutoutTranslate_z,
                        extendoLengthX,
                        flashlightRadius,
                        flashlightTranslate,
                        holderLength_z,
                        roundiness,
                        showFlashlight,
                        yLength,
                        zLengthTranslate)
{
    union()
    {    
        flashlightHolder_basketAttachment(yLength = yLength,
                        zLength = basketAttachment_zLength,
                        zLengthTranslate = zLengthTranslate);

        // extendo
        color("blue")
        cube([extendoLengthX, yLength, 5]);

        // flashlight holder and cutout    
        flashlightHolder_coreFront(extendoLengthX = extendoLengthX,
                                flashlightTranslate = flashlightTranslate,
                            flashlightRadius = flashlightRadius,
                            holderLength_z = holderLength_z,
                            length_z_SUS = holderLength_z, 
                            roundiness = roundiness,
                            yLength = yLength);
    }
}

module flashlightHolder_basketAttachment(yLength, 
                                         zLength,
                                         zLengthTranslate)
{
    difference()
    {
        xLength = 15;
        color("black")
        cube([xLength, yLength, zLength]);    

        // lower cutout
        cutoutLength = yLength + 5 * 2;
        xTranslate = xLength * 0.5;
        yTranslate = cutoutLength - 5;
        zTranslate = zLength * zLengthTranslate;
        color("green")
        translate([xTranslate, yTranslate, zTranslate])
        rotate([90, 0,0])
        cylinder(r = 4, h = cutoutLength, $fn = 60);       

        // upper cutout
        color("green")
        translate([xTranslate, yTranslate, zTranslate + 36])
        rotate([90, 0,0])
        cylinder(r = 4, h = cutoutLength, $fn = 60);    
    }
}


module flashlight(radius, roundiness, translate)
{
    length = 91;   // this was measured
    extendedLength = 102;  // this was measured (not used, so far)

    // handle
    translate(translate)
    rotate([0,90,0])
    %cylinder(r = radius, h = length, $fn = roundiness);

    // light
    lightHeight = 5;
    lightTranslate = [translate[0] + length - lightHeight,
                        translate[1],
                        translate[2]];
    color("yellow")
    translate(lightTranslate)
    rotate([0,90,0])
    %cylinder(r = radius, 
              h = lightHeight, 
              $fn = roundiness);
}

module flashlightHolder_coreFront(extendoLengthX, 
                                flashlightRadius,
                                flashlightTranslate,
                                holderLength_z, 
                                length_z_SUS, 
                                roundiness,
                                yLength)
{
        color("pink")
        translate([extendoLengthX,0,0])
        cube([5, yLength, holderLength_z]);
}
