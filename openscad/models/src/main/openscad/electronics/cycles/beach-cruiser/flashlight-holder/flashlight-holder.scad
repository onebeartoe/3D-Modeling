
module flashlightHolder(extendoLengthX = 35,
                        flashlightRadius = 9,
                        roundiness = 90,
                        showFlashlight = false,
                        yLength = 30)
{
    // basket attachment
    cube([5, yLength, 10]);

    // extendo
    cube([extendoLengthX, yLength, 5]);

    // flashlight holder and cutout
    holderLength_z = 50;
    translate([extendoLengthX,0,0])
    cube([5, yLength, holderLength_z]);

    cutoutTranslate_y = yLength / 2.0;
    cutoutTranslate_z = holderLength_z - flashlightRadius - 10;
    translate([0, cutoutTranslate_y, cutoutTranslate_z])    
    rotate([0,90,0])
    cylinder(r = flashlightRadius, h = 69, $fn = roundiness);


    // flashlight
    if(showFlashlight)
    {
        rotate([0,90,0])
        %cylinder(r = flashlightRadius, h = 3, $fn = roundiness);
    }
}
