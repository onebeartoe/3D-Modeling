
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

    cutoutLengthX = 2.6;
    cutoutLengthY = 18;

    xTranslate = 7;
    yTranslate = (plateLength_y - cutoutLengthY) / 2.0;

    echo("yt:", yTranslate);

    // hour tens cutout
    translate([xTranslate, yTranslate, -0.01])
    cube([cutoutLengthX, cutoutLengthY, 10.02]);

    // hour ones cutout
    dotstarMatrixTixClockPlate_cutouts_hourOnes(cutoutLengthX = cutoutLengthX, cutoutLengthY = cutoutLengthY);
}

module dotstarMatrixTixClockPlate_cutouts_hourOnes(cutoutLengthX, cutoutLengthY)
{

}

function dotstarMatrixTixClockPlate_xLength() = 50;

function dotstarMatrixTixClockPlate_yLength() = 23;
