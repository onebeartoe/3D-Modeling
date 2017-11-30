
/**
 * This is a model of the on/off toggle button from Adafruit.
 *
 *      https://www.adafruit.com/product/1683
 */

 module adafruitOnOffButton1683()
 {
    xLength = adafruitOnOffButton1683_xyLength();
    yLength = adafruitOnOffButton1683_xyLength();
    zLength = adafruitOnOffButton1683_zLength();

    union()
    {
        color("black")
        cube([xLength, yLength, zLength]);

        adafruitOnOffButton1683_pins();
    }
 }

/** Support functions and modules follow. **/

function adafruitOnOffButton1683_xyLength() = 12;

function adafruitOnOffButton1683_zLength() = 6.8;

module adafruitOnOffButton1683_pins()
{
    // This arithmetic is from the dimensions given on the Adafuit product pate.
    xLength = (7.9 + 0.25) - 6; // subtract half the xLength

    yLength = 8;

    zLength = (6.8 / 2.0) + 4;

    xTranslate = adafruitOnOffButton1683_xyLength();
    yTranslate = (adafruitOnOffButton1683_xyLength() - yLength) / 2.0;
    zTranslate = -4;

    color("yellow")
    translate([xTranslate, yTranslate, zTranslate])
    cube([xLength, yLength, zLength]);
}
