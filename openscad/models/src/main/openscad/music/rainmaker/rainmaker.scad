
use <../../shapes/open-cylinder/open-cylinder.scad>

module rainmaker(height,
                    outerRadius,
                    innerRadius)
{
	openCylinder(height = height,
	                    outerRadius = outerRadius,
	                    innerRadius = innerRadius);
}
