
/**
  * This model represents the Adafruit PowerBoost 500 Charger
  *       https://www.adafruit.com/product/1944
  */

use <../../../basics/conversions.scad>
use <../../../electronics/battery-chargers/adafruit-powerboost-500-charger/mounting-holes/powerboost-500-charger-mounting-holes.scad>

module adafruitPowerboost500Charger()
{
    difference()
    {
        adafruitPowerboost500Charger_base();

        xInches = (0.85 - 0.65) / 2.0;
        xyTranslate = inchesToMillimeters(xInches);
        translate([xyTranslate, xyTranslate, -0.01])
        adafruitPowerboost500Charger_mountingHoles();
    }
}

/** Support modules follow. **/

module adafruitPowerboost500Charger_base()
{
    // these inch values are from the Adafruit learn page
    xInches = 1.4;
    yInches = 0.85;

    xLength = inchesToMillimeters(xInches);
    yLength = inchesToMillimeters(yInches);
    zLength = 1;

    size = [xLength, yLength, zLength];
    cube(size = size);

    adafruitPowerboost500Charger_throughHolePins(boardLengthX = xLength,
                                                 boardLengthY = yLength,
                                                 boardLengthZ = zLength);
}

/**
  * This are the USB pins that stick out from through hole soldering.
  */
module adafruitPowerboost500Charger_throughHolePins(boardLengthX, boardLengthY, boardLengthZ)
{
    xLength = 2;
    yLength = 12;

    // This is how much the USB pins stick out of the board
    zLength = 2;

    xTranslate = boardLengthX - xLength - 2;
    yTransate = (boardLengthY - yLength) / 2.0;
    zTranslate = -boardLengthZ;

    translate([xTranslate, yTransate, zTranslate])
    cube([xLength, yLength, zLength]);
}
