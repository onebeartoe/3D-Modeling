
use <../../../../basics/conversions.scad>

module adafruitPowerboost500Charger_mountingHoles()
{
    rInches = 0.1 / 2.0;
    radius = inchesToMillimeters(rInches);
    height = 4;
    sides = 30;

    // these dimensions are from the adafruit learn site
    yInches = 0.65;
//    yInches = (0.85 - 0.65) / 2.0;
    yHoleDelta = inchesToMillimeters(yInches);

    // this is the 'top left standoff; it is on the power/USB end of the Trinket Mini
    translate([0, yHoleDelta, 0])
    cylinder(r=radius, h = height, $fn=sides);

    // this is the 'bottom left' standoff; it is on the reset button end of the Trinket Mini
    cylinder(r=radius, h = height, $fn=sides);
}
