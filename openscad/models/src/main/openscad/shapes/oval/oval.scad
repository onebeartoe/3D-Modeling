
module oval(height = 3,
			radius = 20,
            xScale = 1.2,
            yScale = 1.4,
			fn = 30)
{
	$fn = fn;
	
    scale (v=[xScale, yScale, 1])
    cylinder(h = height, r=radius);
}
