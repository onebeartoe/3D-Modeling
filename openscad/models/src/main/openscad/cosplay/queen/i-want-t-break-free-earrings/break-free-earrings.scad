
use <../../../external-resources/archimedean-spiral/archimedean-spiral.scad>

module breakFreeEarring(height = 3, radius = 35)
{
	union()
	{
		breakFreeEarring_spiral(height, radius);

		breakFreeEarring_center(height);

		breakFreeEarring_clip(height = height, radius = radius);
	}
}

// support modules follow

module breakFreeEarring_center(height)
{
	cylinder(r=5, h=height, center=true);
}

module breakFreeEarring_clip(height, radius)
{
	xyLength = 10;

	xTranslate = radius + (xyLength / 2.0);

	yTranslate = 0;

	translate([xTranslate, yTranslate, 0])
	cube([xyLength, xyLength, height], center = true);
}

module breakFreeEarring_spiral(height, radius)
{
	zScale = height;

	scale([1, 1, zScale])
	archimedean_spiral(rmax = radius,
						spirals=7,
						thickness=3.5);
}
