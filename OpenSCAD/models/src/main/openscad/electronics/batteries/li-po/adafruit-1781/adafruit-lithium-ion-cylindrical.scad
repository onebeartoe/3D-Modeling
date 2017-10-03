
/**
  * This is a model of the lithium polymer battery from Adafruit.
  *
  *       https://www.adafruit.com/product/1781
  */
module adafruitLithiumIonCylindrical()
{
    height = adafruitLithiumIonCylindrical_height();
    cylinder(h = height, r = 9);
}

/** Support modules and function follow **/

function adafruitLithiumIonCylindrical_height() = 69;
