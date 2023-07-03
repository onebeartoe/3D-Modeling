
use <../../../basics/rounded-edges/rounded-cube/rounded-cube.scad>

use <MCAD/shapes.scad>

module wallMountedStand(mount_cube_xLength,
						mount_cube_yLength,
						mount_cube_zLength,
						platform_height,
						platform_segmentCount,
						platform_topRadius,
						support_xLength,
						support_zLength)
{
	union()
	{
		wallMountedStand_platform(height = platform_height,
								  segmentCount = platform_segmentCount,
							  	  topRadius = platform_topRadius);

		wallMountedStand_support(platform_topRadius = platform_topRadius,
								 support_xLength = support_xLength,
								 support_zLength = support_zLength);

		wallMountedStand_mount(cube_xLength = mount_cube_xLength,
							   cube_yLength = mount_cube_yLength,
							   cube_zLength = mount_cube_zLength,
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
								support_xLength,
								support_zLength)
{
	echo("slooop");
	adjacent = support_zLength - 15;
	opposite = support_xLength; //platform_topRadius + 5;
	depth = 10;

	zTranslate = -platform_topRadius;

	color("green")
	translate([zTranslate, 0, 0])
	rotate([180, 90, 90])
	rightTriangle(adjacent, opposite, depth);

	echo("slooop 2");
}

module wallMountedStand_mount(cube_xLength,
							  cube_yLength,
							  cube_zLength,
							  platform_topRadius)
{
	size = [cube_xLength, cube_yLength, cube_zLength];

	cornerRadius = 2;

	xTranslate = -platform_topRadius + cornerRadius;
	yTranslate = -cube_yLength / 2.0;

	difference()
	{
		color("orange")
		translate([xTranslate, yTranslate, 0])
		roundedCube(cornerRadius = cornerRadius,
		            sides=20,
		            sidesOnly=true,
		            size=size);

		wallMountedStand_mountCutouts();
	}
}

module wallMountedStand_mountCutouts()
{
	xTranslate = -70;
	yTranslate = -15;
	zTranslate = 15;

	rotation = [0, 90, 0];

	color("purple")
	translate([xTranslate, yTranslate, zTranslate])
	rotate(rotation)
	cylinder(r=1, h = 80, $fn = 30);

	color("purple")
	translate([xTranslate, -yTranslate, zTranslate])
	rotate(rotation)
	cylinder(r=1, h = 80, $fn = 30);
}
