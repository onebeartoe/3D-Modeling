
use <../../../../shapes/open-cylinder/open-cylinder.scad>

blockHeight = 12;
blockSideX = 49.5;
blockSideY = 43.50;

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

module attachmentSlantCutout()
{
	color("orange")
	
	rotate([0, -35, 0])
	translate([-3.2, -9, -6.0])
	cube([10,130, 20]);	
}

module block()
{
	x = blockSideX;
	y = blockSideY;
	z = blockHeight;
	
	cube([x, y, z]);	
}

module blockCutouts()
{
	translate([0,0,-0.01])
	eyeCutout();
	
	attachmentSlantCutout();
	
	blockCutout1();
	
	blockCutout2();
}

module blockCutout1()
{
	trnaslateX = 40;
	translateY = 0;
	color("pink")
	rotate([0,0,-20])
	translate([trnaslateX, translateY, -0.01])
	cube([15, blockSideY, blockHeight+1]);
}

module blockCutout2()
{
	trnaslateX = 28;
	translateY = 18;
	color("green")
	rotate([0,0,-43])
	translate([trnaslateX, translateY, -0.01])
	cube([15, blockSideY, blockHeight+1]);		
}

module eyepieceBlock()
{
	// comment this next line to see the cutout pieces
	difference()
	{
		block();
		
		blockCutouts();
	}
}

module eyepieceBlockAdornments()
{
	outerRing();
	
	innerRing();
	
	eyeStrapLoop();
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
		eyepieceBlock();
		
		eyepieceBlockAdornments();
	}
}

module eyeStrapLoop()
{
	height = 2;
	side = 14;
	
	difference()
	{
		color("orange")
		translate([49, 29.5, 0])
		cube([side, side, height]);
		
		translate([51,32,-0.1])
		cube([9, 9, height+1]);
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
	difference()
	{
		outerR = 20.0;
		innerR = outerR - ringThickness; 
		translate(ringTranslate)
		openCylinder(height=cylinderHeight, outerRadius=outerR, innerRadius=innerR);
		
		blockCutouts();
	}
}
	
module stlVersion()
{
	//
	import("C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\wearables\\el-wire-cyborg-eye\\Fiore9\\El_Wire_Cyborg_Eye\\files\\cyborg_eye_right.stl");
}
