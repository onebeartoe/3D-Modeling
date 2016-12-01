
nefertitiLaForge();

module nefertitiLaForge()
{
	union()
	{
//		scale([0.5, 0.5, 0.5])
		import("nefertiti.stl");
		
		translate([55.01, 22, 134])
		rotate([0, 0, 90])
		scale([0.37, 0.37, 0.37])
		import("VISOR_V3_Fitted_Unsupported.stl");	
	}
}

