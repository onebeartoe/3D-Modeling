
// offset original
showOffsetOriginal = false;
if(showOffsetOriginal)
{
	translate([0, -200, 0])
	color("yellow")
	import("C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\star-trek\\jordi-laforge\\visor\\MrJohn\\Geordi_La_Forges_Visor_Star_Trek\\VISOR_V3_Fitted_Unsupported.stl");	
}

// overlay of original visor
showOverlay = false;
if(showOverlay)
{
	color("yellow")
	import("C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\star-trek\\jordi-laforge\\visor\\MrJohn\\Geordi_La_Forges_Visor_Star_Trek\\VISOR_V3_Fitted_Unsupported.stl");
}

height = 4;

centerGap = 21;

ovalScale = [1, 1.1, 1];

union()
{
	translate([30, 0, 0])
	geordilaForgeVisor();
	
//	translate([-25, 0, 0])
//	cube([50, 50, 50]);	
}


module centerParts()
{
	outerIconCount = 25;
	
    for ( i = [0 : outerIconCount] )
    {
        rotate( i * 180 / (outerIconCount), [0, 0, 1])
        translate([0, 70, height - 0.1])
        cylinder(r=2, h=centerGap + 0.2);
    }
}

module geordilaForgeVisor()
{
	union()
	{
		horizontalPlane();
		
		scale(ovalScale)
		centerParts();
		
		zTranslate = height + centerGap;
		translate([0, 0, zTranslate])
		horizontalPlane();
	}
}

module horizontalPlane()
{
	difference()
	{
		horizontalPlaneUnion();
		
		// large rectagngle cutout
		xLength = 105;
		xTranslate = -30;
		yLength = 100;
		yTranslate = -yLength / 2.0;
		translate([xTranslate, yTranslate, -0.1])		
		cube([xLength, yLength, height+0.2]);
		
		// cut out section 1
		cu1Radius = 22;
		cu1TranslateX = -9;
		cu1TranslateY = -40;
		translate([cu1TranslateX, cu1TranslateY, -0.1])
		cylinder(r=cu1Radius, h=height+0.2);
		
		translate([cu1TranslateX, -cu1TranslateY, -0.1])
		cylinder(r=cu1Radius, h=height+0.2);

		// cut out section 2
		cu2LengthX = 70;		
		cu2RotateZ = -14;
		cu2TranslateX = -11;
		cu2TranslateZ = -62;
		translate([cu2TranslateX, cu2TranslateZ, -0.1])
		rotate([0, 0, cu2RotateZ])
		cube([cu2LengthX, 40, height+0.11]);


		cu2bTranslateZ = (height) + 0.1;
		color("green")
		translate([cu2TranslateX, -cu2TranslateZ, cu2bTranslateZ])
		rotate([180, 0, -cu2RotateZ])
		cube([cu2LengthX, 40, height+0.12]);		
	}
}

module horizontalPlaneUnion()
{
	union()
	{
		scale(ovalScale)
		cylinder(r=75, h=height);
		
		// rounded ends
		u1TranslateX = 31;
		u1TranslateY = -77;
		translate([u1TranslateX, u1TranslateY, 0])
		cylinder(r=5, h=height);
		
		translate([u1TranslateX, -u1TranslateY, 0])
		cylinder(r=5, h=height);
		
		// fillers for the main oval and the rounded ends
		u2TranslateX = 3;
		u2TranslateY = -82;
		u2LengthX = 30;
		u2LengthY = 10;
		translate([u2TranslateX, u2TranslateY,0])
		cube([u2LengthX, u2LengthY, height]);
		
		color("blue")
		translate([u2TranslateX, -u2TranslateY-10,0])
		cube([u2LengthX, u2LengthY, height]);
	}		
}
	