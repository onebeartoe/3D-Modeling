
include <creeper-face-matrices.scad>

tilesWide = 8;

tileSize = 5;

module creeperFace()
{
    for(x = [0:tilesWide-1])
    {
        for(y = [0: tilesWide-1])
        {
            dx = x * tileSize;
            dy = y * tileSize;
            
            c = colorMatrix[y][x] == "b" ? "black" : "green";
//            c = upsideDownColorMatrix[y][x] == "b" ? "black" : "green";
            if(c == "black")
            {
                tile(dx, dy, c);
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