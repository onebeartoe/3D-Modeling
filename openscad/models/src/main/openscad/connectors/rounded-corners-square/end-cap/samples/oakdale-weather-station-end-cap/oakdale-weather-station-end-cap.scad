
use <../../../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

use <../../rounded-corner-end-cap.scad>

zLength = 2;
cornerRadius = 5;

innerWidth = cornerRadius + 51;
innerSize = [innerWidth, innerWidth, zLength];

outerWidth = innerWidth + 2;
outerSize = [outerWidth, outerWidth, zLength];

difference()
{
    roundedCornerEndcap(innerLength = innerWidth,
                        innerWidth = innerWidth,
                        innerSize = innerSize,
                        innerCornerRadius = cornerRadius,

                        outerLength = outerWidth,
                        outerWidth = outerWidth,
                        outerSize = outerSize,
                        outerCornerRadius = cornerRadius);

    xyTranslate = cornerRadius;
    cutoutSideLength = cornerRadius + 17 // needs to be 22
                        + xyTranslate;

    cutoutSize = [cutoutSideLength, cutoutSideLength, zLength+5];
    translate([-xyTranslate, -xyTranslate, -0.01])
    roundedCube(cornerRadius = cornerRadius,
                    sides=20,
                    sidesOnly=true,
                    size=cutoutSize);
}
