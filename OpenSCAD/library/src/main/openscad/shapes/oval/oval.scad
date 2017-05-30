
oval();

module oval(height = 3,
            xScale = 1.2,
            yScale = 1.4)
{
    scale (v=[xScale, yScale, 1]) 
    cylinder(h = height, r=20);
}