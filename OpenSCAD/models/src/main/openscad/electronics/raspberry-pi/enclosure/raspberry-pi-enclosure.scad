
// this next use statement is from
//         https://github.com/saarbastler/library.scad/blob/master/raspberrypi.scad
//         and
//         https://www.thingiverse.com/thing:2023897
//use </home/roberto/Versioning/group/github/saarbastler/library.scad/raspberrypi.scad>

use <../../../basics/rounded-edges/rounded-cube-enclosure/rounded-cube-enclosure.scad>

module raspberryPiEnclosure()
{
    cornerRadius = 3;
    boardLengthX = 90;
    boardLengthY = 75;
    boardLengthZ = 30;

    roundedCubeEnclosure(boardLengthX = boardLengthX,
                                    boardLengthY = boardLengthY,
                                    boardLengthZ = boardLengthZ,
                                    cornerRadius = cornerRadius,
                                    xAxisCutout_yPercentage = 0.8,
                                    xAxisCutout_zPercentage = 0.8,
                                    yAxisCutout_xPercentage = 0.85,
                                    yAxisCutout_zPercentage = 0.75);

//    raspberryPi3();
}

module raspberryPi3()
{
    xTranslate = 45;
    yTranslate = 38;
    zTranslate = 5;

    translate([xTranslate, yTranslate, zTranslate])
    pi3();
}
