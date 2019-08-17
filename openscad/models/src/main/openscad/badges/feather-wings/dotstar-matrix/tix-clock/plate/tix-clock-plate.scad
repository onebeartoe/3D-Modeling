
module dotstarMatrixTixClockPlate()
{
    difference()
    {
        xLength = dotstarMatrixTixClockPlate_xLength();
        yLength = dotstarMatrixTixClockPlate_yLength();

        cube([xLength, 23, 1]);

        dotstarMatrixTixClockPlate_cutouts();
    }
}

module dotstarMatrixTixClockPlate_cutouts(plateLength_x, plateLength_y)
{
    plateLength_x = dotstarMatrixTixClockPlate_xLength();
    plateLength_y = dotstarMatrixTixClockPlate_yLength();

    cutoutLengthX = dotstarMatrixTixClockPlate_cutouts_xLength();
    cutoutLengthY = dotstarMatrixTixClockPlate_cutouts_yLength();

    xTranslate = dotstarMatrixTixClockPlate_cutouts_hourTens_xTranslate();
    yTranslate = dotstarMatrixTixClockPlate_cutouts_hourTens_yTranslate();

    echo("yt:", yTranslate);

    // hour tens cutout
    translate([xTranslate, yTranslate, -0.01])
    cube([cutoutLengthX, cutoutLengthY, 1.02]);

    // hour ones cutout
    dotstarMatrixTixClockPlate_cutouts_hourOnes();

    dotstarMatrixTixClockPlate_cutouts_minuteTens();
}

module dotstarMatrixTixClockPlate_cutouts_hourOnes()
{
    xTranslate = dotstarMatrixTixClockPlate_cutouts_hourTens_xTranslate()
                 + dotstarMatrixTixClockPlate_cutouts_xLength() * 2;

    yTranslate = dotstarMatrixTixClockPlate_cutouts_hourTens_yTranslate();

    cutoutLengthX = dotstarMatrixTixClockPlate_cutouts_xLength() * 3;
    cutoutLengthY = dotstarMatrixTixClockPlate_cutouts_yLength();

    translate([xTranslate, yTranslate, -0.01])
    cube([cutoutLengthX, cutoutLengthY, 1.02]);
}

module dotstarMatrixTixClockPlate_cutouts_minuteTens()
{

}

function dotstarMatrixTixClockPlate_xLength() = 50;

function dotstarMatrixTixClockPlate_yLength() = 23;

function dotstarMatrixTixClockPlate_cutouts_xLength() = 2.6;

function dotstarMatrixTixClockPlate_cutouts_yLength() = 18;

function dotstarMatrixTixClockPlate_cutouts_hourTens_xTranslate() = 7;

function dotstarMatrixTixClockPlate_cutouts_hourTens_yTranslate() = (dotstarMatrixTixClockPlate_yLength()
                                                                        - dotstarMatrixTixClockPlate_cutouts_yLength())
                                                                        / 2.0;