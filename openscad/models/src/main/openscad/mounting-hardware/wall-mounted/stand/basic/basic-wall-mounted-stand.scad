
// This model was slightly inspired the shap of this thing:
//
//	https://www.thingiverse.com/thing:2831475

use <../wall-mounted-stand.scad>

module basicWallMountedStand(mount_cube_yLength,
							 platform_height,
							 platform_segmentCount,
						 	 platform_topRadius,
						 	 support_height)
{
	wallMountedStand(mount_cube_yLength = mount_cube_yLength,
					 platform_height = platform_height,
					 platform_segmentCount = platform_segmentCount,
				 	 platform_topRadius = platform_topRadius,
				 	 support_height = support_height);
}
