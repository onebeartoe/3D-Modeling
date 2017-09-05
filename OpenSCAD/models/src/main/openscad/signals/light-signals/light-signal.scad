
use <../../shapes/open-cylinder/open-cylinder.scad>

signalText = "Impalas";

plaqueHeight = 3;

baseHeight = 2;

showOriginal = false;

lightSignal();

module lightSignal()
{
	difference()
	{
		signalShell();
		
		plaque();
	}
}

module plaque()
{
	font = "Bauhaus 93:style=Regular";
	fontSize = 7.5;
	xTranslate = -18;
	translate([xTranslate, -3,-3])
	linear_extrude(height=6)
	text(signalText, font = font, size=fontSize);
}

module signalShell()
{
	signalStl = "C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\super-heroes\\batman\\bat-signal\\customizable_phone_bat_signal_20150130-9347-hv0ikc-0.stl";

	// DO NOT CHANGE THE RADIUS; IT MACHES THE ORIGINAL MODEL		
	stlBaseInnerRadius = 18.5;
	stlBaseOuterRadius = stlBaseInnerRadius + 2.5;
	 
	union()
	{
		// this is the top hole/cutout
		zTopHoleTranslate = 35;
		color("blue")
		translate([0, 0, zTopHoleTranslate])
		openCylinder(height=1, outerRadius = 12, innerRadius=6);
		
		// connector for the shaft and top hole
		color("pink")
		translate([0, 0, zTopHoleTranslate-3])
		openCylinder(height=3.1, outerRadius = 19, innerRadius=8);
		
		// this is the bottom wide shaft
		zTranslate = -baseHeight / 2.0;
		color("orange")
		translate([0, 0, zTranslate])	
		openCylinder(height=zTopHoleTranslate, outerRadius = stlBaseOuterRadius, innerRadius = stlBaseInnerRadius);
		
		// this thing was modeld after this original
		if(showOriginal)
		{
			color("yellow")
			translate([0, 0, zTranslate])
			import(signalStl);
		}
		
		// This is the bottome disk, that holds the text/icon cutout.
		color("green")
		cylinder(r=stlBaseInnerRadius+0.1, h=baseHeight, center=true);
	}
}
