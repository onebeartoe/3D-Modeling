
module paintMixerBit(adapterRadius = 10,
                     bitShaftLength = 30)
{
    union()
    {
        bitAdapter(adapterRadius = adapterRadius,
                   bitShaftLength = bitShaftLength);

        spacerHeight = 10;
        spacer(adapterRadius = adapterRadius,
               bitShaftLength = bitShaftLength,
               spacerHeight = spacerHeight);

        drillAdapter(adapterRadius, bitShaftLength, spacerHeight);
    }
}

module bitAdapter(adapterRadius, bitShaftLength)
{
    difference()
    {
        cylinder(r = adapterRadius, 
                 h = bitShaftLength, $fn = 90);
 
        bitCutout(bitShaftLength);
    }
}

module bitCutout(bitShaftLength)
{
    sidesCount = 6;
    sidesRadius = 4.5;  
    height = bitShaftLength + 0.2;
    translate([0, 0, -0.1])
    cylinder(r = sidesRadius, h = height, $fn = sidesCount);
}

module drillAdapter(adapterRadius, bitShaftLength, spacerHeight) 
{
    zTranslate = bitShaftLength + spacerHeight - 0.1;
    translate([0, 0, zTranslate])
    difference()
    {
        drillAdapterHeight = 30;
        cylinder(r = adapterRadius, 
                    h = drillAdapterHeight,
                    $fn = 90);

        cutoutHeight = drillAdapterHeight + 0.1;
        cutoutWidth = 10;
        xyTranslate = -cutoutWidth / 2.0;
        cutoutY = 1.5;
        color("red")
        translate([xyTranslate, -cutoutY / 2.0, 0])
        cube([cutoutWidth, cutoutY, cutoutHeight]);

        color("green")
        rotate([0, 0, 90])
        translate([xyTranslate, -cutoutY / 2.0, 0])
        cube([cutoutWidth, cutoutY, cutoutHeight]);
    }
}

module spacer(adapterRadius, bitShaftLength, spacerHeight)
{
    zTranslate = bitShaftLength - 0.1;
    translate([0, 0, zTranslate])
    cylinder(r = adapterRadius, 
                 h = spacerHeight, 
                 $fn = 90);
}
