 
use <../../../shapes/open-oval/open-oval.scad>

use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

textures:

    https://www.thingiverse.com/thing:6069270

    https://github.com/joh/texture-surface

3D Curve

    https://www.thingiverse.com/thing:241777/files

module pictureFrameWithStand(borderWidth = 10, 
                             cutoutDepth = 10, 
                             cutoutHeight = 74 + 1,
                             cutoutWidth = 138 + 1,
                             ) 
{
    union()
    {
        frame(borderWidth = borderWidth,                     
              cutoutDepth= cutoutDepth,                    
              cutoutHeight = cutoutHeight,                    
              cutoutWidth = cutoutWidth);

        stand();
    }
}

module frame(borderWidth, cutoutWidth, cutoutHeight, cutoutDepth)
{
    difference()
    {
        frameSolids(borderWidth = borderWidth,                     
                    cutoutDepth= cutoutDepth,                    
                    cutoutHeight = cutoutHeight,                    
                    cutoutWidth = cutoutWidth);

        frameCutout();
    }
}

module frameCutout()
{

}

module frameSolids(borderWidth,
                   cutoutWidth, 
                   cutoutHeight, 
                   cutoutDepth,) 
{
    union()
    {
        xLength = cutoutWidth + borderWidth;
        yLength = cutoutHeight + borderWidth;
        zLength = cutoutDepth;

        size = [xLength, yLength, zLength];
        color("green")
        translate([0, 0, 0])
        roundedCube(cornerRadius = 5,
                    cubeCentered=true,
                    sides=20,
//                    sidesOnly=true,
                    size=size);
                    
use a roundedDisk!!                    
        ovalXLength = cutoutWidth + borderWidth;
        ovalYLength = cutoutHeight + borderWidth;
        ovalZLength = cutoutDepth;                    
        openOval(
                 borderThickness = cutoutHeight,
                 xLength = ovalXLength,
                 yLength = ovalYLength,        
                 zLength = ovalZLength,);                            
    }
}
