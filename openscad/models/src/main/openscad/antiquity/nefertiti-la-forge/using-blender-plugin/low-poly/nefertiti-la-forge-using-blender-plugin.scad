
/**
 *  when you export in Blender, use 
 
		select object -> Wrench tool -> Decimate -> Planar -> Select 'All Boundaries' -> Angle Limit: 5-> Apply -> File -> Export -> .scad
*/

use <C:\home\world\world-distribute\3D-Printing\Busts\Nefertiti_Bust\low-poly\blender-nefertiti.scad>
use <../../../cosplay\star-trek\geordi-la-forge-visor\geordi-la-forge-visor.scad>

nefertitiLaForge();

module nefertitiLaForge()
{
	union()
	{		
		Nefertiti_001();

		scaleFactor = 0.42;
		translate([55, 26, 133])
		rotate([0, 4, 90])
		scale([scaleFactor, scaleFactor, scaleFactor])
		geordilaForgeVisor();
			
	}
}