
use <../basic-wall-mounted-stand.scad>

mount_cube_yLength = 40; // [20 : 150]

platform_height = 6; // [5 : 50]
platform_segmentCount = 60; // [3 : 130]
platform_topRadius = 50; // [25: 100]

support_height = 50; // [20 : 250]

basicWallMountedStand(mount_cube_yLength = mount_cube_yLength,
					  platform_height = platform_height,
					  platform_segmentCount = platform_segmentCount,
				  	  platform_topRadius = platform_topRadius,
				  	  support_height = support_height);
