
use <../../../../basics/rounded-edges/rounded-cube-enclosure/rounded-cube-enclosure.scad>

use <../../../../electronics/battery-chargers/adafruit-powerboost-500-charger/mounting-holes/powerboost-500-charger-mounting-holes.scad>

use <../../../batteries/li-po/adafruit-1781/adafruit-lithium-ion-cylindrical.scad>

module powerboost500ChargerEnclosure()
{
    union()
    {
        powerboost500ChargerEnclosure_chargerStandoffs();

        powerboost500ChargerEnclosure_buttonMount();

        powerboost500ChargerEnclosure_baseWithCutouts();
    }
}

/** Support modules and functions follow **/

module powerboost500ChargerEnclosure_baseWithCutouts()
{
    difference()
    {
        boardLengthZ = 25;
        //        buttonSide = 12;
        cornerRadius = 3;
        boardLengthX = 80;
        boardLengthY = 66;
        roundedCubeEnclosure(boardLengthX = boardLengthX,
                                        boardLengthY = boardLengthY,
                                        boardLengthZ = boardLengthZ,
                                        cornerRadius = cornerRadius,
                                        xAxisCutout_yPercentage = 0.8,
                                        xAxisCutout_zPercentage = 0.8,
                                        yAxisCutout_xPercentage = 0.85,
                                        yAxisCutout_zPercentage = 0.75);

        xyzScale = 1.08; // scale the size up by 2mm
//        xyzScale = 1.04; // scale the size up by 1mm
        cutoutLengthX = adafruitLithiumIonCylindrical_height() * xyzScale;
        xTranslate = (boardLengthX - cutoutLengthX ) / 2.0;
        translate([xTranslate, 16, 8])
        scale([xyzScale, xyzScale, xyzScale])
        rotate([0,90,0])
        adafruitLithiumIonCylindrical();

        // This is the top panel cutout to expose the on/off button.
        translate([34, 67, 20])
        cylinder(h=20, r=10);
    }
}

module powerboost500ChargerEnclosure_buttonMount()
{
    xTranslate = 28;
    yTransate = 59.4;
    zTransate = 0.2;

    translate([xTranslate, yTransate, zTransate])
    cube([10, 8, 6.9]);
}

module powerboost500ChargerEnclosure_chargerStandoffs()
{
    xTranslate = 25;
    yTranslate = 39;
    zTranslate = 0;

    translate([xTranslate, yTranslate, zTranslate])
    adafruitPowerboost500Charger_mountingHoles();
}
