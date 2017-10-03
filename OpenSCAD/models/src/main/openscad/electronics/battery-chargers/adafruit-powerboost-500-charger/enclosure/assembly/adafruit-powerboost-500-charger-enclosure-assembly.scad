
use <../adafruit-powerboost-500-charger-enclosure.scad>

use <../../adafruit-powerboost-500-charger.scad>

use <../../../../batteries/li-po/adafruit-1781/adafruit-lithium-ion-cylindrical.scad>

use <../../../../buttons/on-off/adafruit-1683/adafruit-on-off-button-1683.scad>

module adafruitPowerBoost500ChargerEncosureAssembly()
{
    powerboost500ChargerEnclosure();

    color("green")
    translate([5, 16, 8])
    rotate([0,90,0])
    adafruitLithiumIonCylindrical();

    translate([28,68, 7.2])
    rotate([0,0,-90])
    adafruitOnOffButton1683();

    translate([20,35, 4])
    adafruitPowerboost500Charger();
}
