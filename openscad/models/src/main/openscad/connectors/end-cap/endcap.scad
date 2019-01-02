
use <../../shapes/open-cylinder/open-cylinder.scad>

module endcap(height = 10,
				innerRadius = 20,
				outerRadius = 24,
				endThickness = 3)
{
	union()
	{
		openCylinder(innerRadius = innerRadius,
						height = height, 
						outerRadius = outerRadius);

		endcap_end(height = endThickness,
					outerRadius = outerRadius);
	}
}

// support moduiles follow

module endcap_end(height, outerRadius)
{
	cylinder(h = height,
				r = outerRadius);
}
