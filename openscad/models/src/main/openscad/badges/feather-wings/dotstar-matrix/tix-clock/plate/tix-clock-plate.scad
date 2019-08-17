
module dotstarMatrixTixClockPlate()
{
/*
    svgScale = 0.0927;
    color("blue")
    translate([-0.029, -6.6, -11])
    scale([svgScale, svgScale, svgScale])
    surface("adafruit-dotstar-wing.png");
*/

    difference()
    {
        xLength = dotstarMatrixTixClockPlate_xLength();
        yLength = dotstarMatrixTixClockPlate_yLength();

        cube([xLength, 23, 1]);

        dotstarMatrixTixClockPlate_cutouts();
    }
}

module dotstarMatrixTixClockPlate_cutouts()
{
    cutoutLengthX = dotstarMatrixTixClockPlate_cutouts_xLength();
    cutoutLengthY = dotstarMatrixTixClockPlate_cutouts_yLength();

    xTranslate = dotstarMatrixTixClockPlate_cutouts_hourTens_xTranslate();
    yTranslate = dotstarMatrixTixClockPlate_cutouts_hourTens_yTranslate();

    // hour tens cutout
    translate([xTranslate, yTranslate, -0.01])
    cube([cutoutLengthX, cutoutLengthY, 1.02]);

    // hour ones cutout
    dotstarMatrixTixClockPlate_cutouts_hourOnes();

    dotstarMatrixTixClockPlate_cutouts_minuteTens();

    dotstarMatrixTixClockPlate_cutouts_minuteOnes();
}

module dotstarMatrixTixClockPlate_cutouts_hourOnes()
{
    xTranslate = dotstarMatrixTixClockPlate_cutouts_minuteTens_xTranslate()
                 ;

    yTranslate = dotstarMatrixTixClockPlate_cutouts_hourTens_yTranslate();

    cutoutLengthX = dotstarMatrixTixClockPlate_cutouts_xLength() * 3;
    cutoutLengthY = dotstarMatrixTixClockPlate_cutouts_yLength();

    translate([xTranslate, yTranslate, -0.01])
    cube([cutoutLengthX, cutoutLengthY, 1.02]);
}

module dotstarMatrixTixClockPlate_cutouts_minuteTens()
{
    xTranslate = dotstarMatrixTixClockPlate_cutouts_minuteTens_xTranslate()
                 + dotstarMatrixTixClockPlate_cutouts_xLength() * 4;

    yTranslate = dotstarMatrixTixClockPlate_cutouts_hourTens_yTranslate();

    cutoutLengthX = dotstarMatrixTixClockPlate_cutouts_xLength() * 2;
    cutoutLengthY = dotstarMatrixTixClockPlate_cutouts_yLength();

    translate([xTranslate, yTranslate, -0.01])
    cube([cutoutLengthX, cutoutLengthY, 1.02]);
}

module dotstarMatrixTixClockPlate_cutouts_minuteOnes()
{
    xTranslate = dotstarMatrixTixClockPlate_cutouts_minuteTens_xTranslate()
                 + dotstarMatrixTixClockPlate_cutouts_xLength() * 7;

    yTranslate = dotstarMatrixTixClockPlate_cutouts_hourTens_yTranslate();

    cutoutLengthX = dotstarMatrixTixClockPlate_cutouts_xLength() * 3;
    cutoutLengthY = dotstarMatrixTixClockPlate_cutouts_yLength();

    translate([xTranslate, yTranslate, -0.01])
    cube([cutoutLengthX, cutoutLengthY, 1.02]);
}

function dotstarMatrixTixClockPlate_cutouts_minuteTens_xTranslate() = dotstarMatrixTixClockPlate_cutouts_hourTens_xTranslate()
                                                           + dotstarMatrixTixClockPlate_cutouts_xLength() * 2;


function dotstarMatrixTixClockPlate_cutouts_hourOnes_xTranslate() = 0;


function dotstarMatrixTixClockPlate_xLength() = 50;

function dotstarMatrixTixClockPlate_yLength() = 23;

function dotstarMatrixTixClockPlate_cutouts_xLength() = 2.6;

function dotstarMatrixTixClockPlate_cutouts_yLength() = 18;

function dotstarMatrixTixClockPlate_cutouts_hourTens_xTranslate() = 7;

function dotstarMatrixTixClockPlate_cutouts_hourTens_yTranslate() = (dotstarMatrixTixClockPlate_yLength()
                                                                        - dotstarMatrixTixClockPlate_cutouts_yLength())
                                                                        / 2.0;
