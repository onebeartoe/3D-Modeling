
use <../../../../shapes/open-cylinder/open-cylinder.scad>

cylinderHeight = 17.5;

innerRingOuterRadius = 14.5;

ringTranslate = [23.0, 22.0, 0];

ringThickness = 2.1;

// this one is the reference version
//translate([282, 0, 0])
//stlVersion();

// this one is inside the openscad version (for sizing)
//color("green")
//translate([282, -65, 0])
//stlVersion();

eyePiece();

module basePiece()
{
	difference()
	{
		block();
		
		blockCutouts();
	}
}

module baseAdornments()
{
	outerRing();
	
	innerRing();
}		

module block()
{
	x = 49.5;
	y = 43.50;
	z = 12;
	
	cube([x, y, z]);	
}

module blockCutouts()
{
	translate([0,0,-0.01])
	eyeCutout();
	
	
}

module eyeCutout()
{
	radius = innerRingOuterRadius - ringThickness;	
	translate(ringTranslate)
	cylinder(r=radius, h=30);	
}

module eyePiece()
{
	union()
	{
		basePiece();
		
		baseAdornments();
	}
}

module innerRing()
{
	innerR = innerRingOuterRadius - ringThickness;
	translate(ringTranslate)
	openCylinder(height=cylinderHeight, outerRadius=innerRingOuterRadius, innerRadius=innerR);
}

module outerRing()
{
	outerR = 20.0;
	innerR = outerR - ringThickness; 
	translate(ringTranslate)
	openCylinder(height=cylinderHeight, outerRadius=outerR, innerRadius=innerR);
}
	
module stlVersion()
{
	//
	import("C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\wearables\\el-wire-cyborg-eye\\Fiore9\\El_Wire_Cyborg_Eye\\files\\cyborg_eye_right.stl");
}
