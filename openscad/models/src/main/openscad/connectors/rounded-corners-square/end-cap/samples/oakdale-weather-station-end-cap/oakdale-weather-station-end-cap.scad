
use <../../rounded-corner-end-cap.scad>

zLength = 2;
cornerRadius = 5;

innerWidth = cornerRadius + 60;
innerSize = [innerWidth, innerWidth, zLength];

outerWidth = innerWidth + 2;
outerSize = [outerWidth, outerWidth, zLength];

roundedCornerEndcap(innerLength = innerWidth,
                    innerWidth = innerWidth,
                    innerSize = innerSize,
                    innerCornerRadius = cornerRadius,

                    outerLength = outerWidth,
                    outerWidth = outerWidth,
                    outerSize = outerSize,
                    outerCornerRadius = cornerRadius);
