
module flashlightHolder(extendoLengthX = 35,
                        flashlightRadius = 9,
                        roundiness = 90,
                        showFlashlight = false,
                        yLength = 30)
{
    basketAttachment(yLength = yLength);

    // extendo
    cube([extendoLengthX, yLength, 5]);

    // flashlight holder and cutout
    holderLength_z = 50;
    translate([extendoLengthX,0,0])
    cube([5, yLength, holderLength_z]);

    // flashlight cutout
    cutoutTranslate_y = yLength / 2.0;
    cutoutTranslate_z = holderLength_z - flashlightRadius - 10;
    color("green")
    translate([0, cutoutTranslate_y, cutoutTranslate_z])    
    rotate([0,90,0])
    cylinder(r = flashlightRadius, h = 69, $fn = roundiness);


    // flashlight
    if(showFlashlight)
    {
        flashlight();
    }
}

module basketAttachment(yLength)
{
//    difference()
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

        // secondYTranslate = yLength * 0.6666666;
        // color("green")
        // translate([xTranslate, secondYTranslate, zTranslate])
        // rotate([0, 90,0])
        // cylinder(r = 4, h = cutoutLength, $fn = 60);        
    }
}

module flashlight()
{
    rotate([0,90,0])
    %cylinder(r = flashlightRadius, h = 3, $fn = roundiness);
}