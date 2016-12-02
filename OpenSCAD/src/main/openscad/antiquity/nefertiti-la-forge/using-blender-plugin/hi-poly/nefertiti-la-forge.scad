
/**
 *  when you export in Blender, use 
 
		select object -> Wrench tool -> Decimate -> Planar -> Select 'All Boundaries' -> Angle Limit: 5-> Apply -> File -> Export -> .scad
*/

use <C:\home\world\versioning\beto-land-world\3d-printing\antiquity\nefertiti\hi-poly\adafruit\files\Nefertiti-hallow.scad>
use <../../../../cosplay\star-trek\geordi-la-forge-visor\geordi-la-forge-visor.scad>

nefertitiLaForge();

module nefertitiLaForge()
{
	union()
	{		
		Nefertitihollow();

		scaleFactor = 0.6;
		translate([0, -75, 155])
		rotate([0, 4, 90])
		scale([scaleFactor, scaleFactor, scaleFactor])
		geordilaForgeVisor();
		
		// base
		cube([180, 180, 2], center=true);
	}
}