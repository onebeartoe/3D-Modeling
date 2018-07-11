
use <MCAD/shapes.scad>

use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

module wallMountedStand(mount_cube_yLength,
						platform_height,
						platform_segmentCount,
						platform_topRadius,
						support_height)
{
	union()
	{
		wallMountedStand_platform(height = platform_height,
								  segmentCount = platform_segmentCount,
							  	  topRadius = platform_topRadius);

		wallMountedStand_support(platform_topRadius = platform_topRadius,
								 support_height = support_height);

		wallMountedStand_mount(cube_yLength = mount_cube_yLength,
							   platform_topRadius = platform_topRadius);
   }
}

module wallMountedStand_platform(height,
								 segmentCount,
							 	 topRadius)
{
	color("orange")
	cylinder(h=height, r1=topRadius, r2=40, $fn=segmentCount);
}

module wallMountedStand_support(platform_topRadius,
								support_height)
{
	echo("slooop");
	adjacent = support_height - 25;
	opposite = platform_topRadius - 4;
	depth = 40;

	zTranslate = -platform_topRadius;

	color("green")
	translate([zTranslate, 0, 0])
	rotate([180, 90, 90])
	rightTriangle(adjacent, opposite, depth);

	echo("slooop 2");
}

module wallMountedStand_mount(cube_yLength,
							  platform_topRadius)
{
	boardLength = 10;
	boardHeight = 19;

	size = [boardLength, cube_yLength, boardHeight];

	xTranslate = -platform_topRadius;

	color("orange")
	translate([xTranslate, 0, 0])
	roundedCube(cornerRadius = 5,
	            sides=20,
	            sidesOnly=true,
	            size=size);
}
