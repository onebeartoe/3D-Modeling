 
use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

module roundedCornerEndcap(innerLength = 50,
                            innerWidth = 80,
                            innerSize = [10, 10, 2],
                            innerCornerRadius = 5,

                            outerLength = 150,
                            outerWidth = 100,
                            outerSize = [15, 15, 2],
                            outerCornerRadius = 5)
{
    union()
    {
        xTranslate = (outerSize[0] / 2.0) - innerSize[0] / 2.0;
        yTranslate = (outerSize[1] / 2.0) - innerSize[1] / 2.0;
        zTranslate = outerSize[2];
        color("green")
        translate([xTranslate, yTranslate, zTranslate ])
        roundedCube(cornerRadius = innerCornerRadius,
                    sides=20,
                    sidesOnly=true,
                    size=innerSize);

        roundedCube(cornerRadius = outerCornerRadius,
                    sides=20,
                    sidesOnly=true,
                    size=outerSize);
    }
}
