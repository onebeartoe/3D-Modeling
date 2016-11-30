
use <write/Write.scad>

font="write/orbitron.dxf"; 		// BlackRose.dxf, orbitron.dxf, Letters.dxf
//font="write/Bauhaus.dxf";

plaqueHeight = 3;

lightSignal();

module lightSignal()
{
	union()
	{
		signalShell();
		
		plaque();
	}
}



module plaque()
{
	difference()
	{
		cube([250, 30, plaqueHeight], center=true);
		
		write("Impala",
		      t = 21.5,
		      h = 16,
		      center = true,
		      font = font,
		      space = 1.5);
	}	
}

module signalShell()
{
	signalStl = "C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\super-heroes\\batman\\bat-signal\\customizable_phone_bat_signal_20150130-9347-hv0ikc-0.stl";
	zTranslate = -plaqueHeight / 2.0; 

	 
	difference()
	{
//		translate([0, 0, zTranslate])	
	//	import(signalStl);
		
		cylinder(r=17, h=4, center=true);
	}
}

