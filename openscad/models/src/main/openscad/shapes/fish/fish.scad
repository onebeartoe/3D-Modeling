
use <../oval/oval.scad>
use <../triangle/triangle.scad>

module fish(bodyRadius = 7, height = 1)
{
	rotate([0, 0, 135])
	union()
	{
		// body
		cylinder(height,bodyRadius,bodyRadius);

		// head end
		translate([-bodyRadius,-bodyRadius,0])
		{
			cube([bodyRadius,bodyRadius,height]);
		}

		// back end
		cube([bodyRadius,bodyRadius,height]);

		// tail
		size = 6.00015;
		xTranslate = bodyRadius + 3;
		yTranslate = bodyRadius + 2;//radius * 2 + 1;
		translate([xTranslate, yTranslate, 0])
		triangle(size= size, height=2);
	}
}

module fishThumbnail()
{
	fish();
}

/** Support functions and modules follow **/

module fish_tail(radius)
{

}
