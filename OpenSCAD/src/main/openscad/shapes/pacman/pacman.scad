
// TODO: move this to external-resources/
        
module pacman(height=5)
{
    difference() 
    {
        cylinder(r=20, center=true, h=height);

        linear_extrude(height=50, center=true, convexity = 10, twist = 0) 
        {
            polygon(points=[[0,0],[100,60],[100,-60]], paths=[[0,1,2]]);
        }
    }
}

module pacmanThumbnail(height = 1)
{
    xyScale = 0.6;
    scale([xyScale,xyScale, 1])
    pacman(height);
}