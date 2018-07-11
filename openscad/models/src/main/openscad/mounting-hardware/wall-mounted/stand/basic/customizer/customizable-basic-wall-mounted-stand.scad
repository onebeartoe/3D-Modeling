
use <../basic-wall-mounted-stand.scad>

mount_cube_xLength = 4;  // [ 2 :  20]
mount_cube_yLength = 50; // [20 : 150]
mount_cube_zLength = 45; // [20 : 150]

platform_height = 6; // [5 : 50]
platform_segmentCount = 60; // [3 : 130]
platform_topRadius = 50; // [25: 100]

support_xLength = 60; // [50 : 100]
support_zLength = 59; // [20 : 250]

basicWallMountedStand(mount_cube_xLength = mount_cube_xLength,
					  mount_cube_yLength = mount_cube_yLength,
					  mount_cube_zLength = mount_cube_zLength,
					  platform_height = platform_height,
					  platform_segmentCount = platform_segmentCount,
				  	  platform_topRadius = platform_topRadius,
					  support_xLength = support_xLength,
				  	  support_zLength = support_zLength);
