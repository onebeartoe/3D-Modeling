
include <creeper-face-matrices.scad>

tilesWide = 8;

tileSize = 5;

/**
 * This approach did not yield a solid (manifold) object in OpenSCAD.
 * 
 * @return 
 */
module creeperFace()
{
//    union()
    {
        for(x = [0:tilesWide-1])
        {
//            union()
            {
                for(y = [0: tilesWide-1])
                {
                    preX = x * tileSize;
                    preY = y * tileSize;

                    dx = x > 0 ? preX - 0.111 : preX;
                    dy = y > 0 ? preY - 0.111 : preY;
                    
                    c = colorMatrix[y][x] == "b" ? "black" : "green";
                    
                    if(c == "black")
                    {
                        tile(dx, dy, c);
                    }
                }
            }
        }
    }
}

module creeperFaceThumbnail(height = 1)
{
    xyScale = 0.65;
 
    t = -(tilesWide * tileSize) / 2.0;
    xTranslate = t * xyScale;
    yTranslate = xTranslate;
    
    translate([xTranslate, yTranslate, 0])
    scale([xyScale, xyScale, 1])
    creeperFace();
}

module tile(x, y, color)
{
    color(color)
    translate([x, y, 0])
    cube([tileSize, tileSize, 1]);
}