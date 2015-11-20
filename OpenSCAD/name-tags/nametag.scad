
// ************* Credits part *************

//  This was origianllay named uploads-b4-df-a6-25-4b-AnyNameSign.scad and came from 
//
//		http://www.thingiverse.com/thing:16193
//
//  Programmed by Fryns - March 2014


// Adapted by Roberto Marquez - onebeartoe - 2015

// Uses Write.scad by HarlanDMii, published on Thingiverse 18-Jan-2012 (thing:16193)	 

// ************* Declaration part *************

showBorder = "Yes"; // [Yes, No]

// This determines how wide the name tag is.
baseWidth=228;	// [228:600]	

// This determines the hieght of the nametag.
baseHeight=54;	// [54:150]

/* [Hidden] */

resolution=50; 	// Use 20 for draft 100 for nice


baseThickness=2;

borderWidth=2;
borderradius=8;
borderdistance=5;	// Distance from edge

holediameter=3;
countersink=2;
holes=4; 			// Choose 0,2 or 4 (others=0)

letterthickness=1;
lettersize=12 ;

font="write/orbitron.dxf"; 		// BlackRose.dxf, orbitron.dxf, Letters.dxf

namematrix =              
[					 	  // Matrix with place and names - add as many rows as you like	 
	[10,"Roberto"],	      //[Y-placement, "Name"],      note: Y-placement of center of text 
	[-10,"Scrum Trooper"],	  //[Y-placement, "Name"]      note: Y-placement of center of text 	
];

// ************* Executable part *************
use <write/Write.scad>	// remember to download write.scad and fonts

nametag_assembly();


// ************* Module part *************

module nametag_assembly() 
{
	color("black") 
	writing();
	
	if(showBorder == "Yes")
	{
		color("black")	
		border();	
	}	
	
	if (holes==2) 
	{
		base2holes();
	}
	else 
	{
		if (holes==4) base4holes();
		else base();
	}
}

module writing()
{
	// max 100 names
	for ( i = [0 : 99] )
	{				
		if (namematrix[i][0]==undef)
		{
			;	// then do nothing
		}
		else 
		{
			translate([0,namematrix[i][0],baseThickness+letterthickness/2])
			write(namematrix[i][1],t=letterthickness,h=lettersize,center=true,font=font);
		}
	}
}

module base2holes() 
{
	difference()
	{
		base();
		translate([-(baseWidth/2-borderdistance*2-borderWidth-countersink-holediameter),0,0])
			hole();
		translate([(baseWidth/2-borderdistance*2-borderWidth-countersink-holediameter),(0),0])
			hole();
	}
}

module base4holes() 
{
	difference(){
		base();
		translate([(baseWidth/2-borderdistance),(baseHeight/2-borderdistance),0])
			hole();
		translate([(baseWidth/2-borderdistance),-(baseHeight/2-borderdistance),0])
			hole();
		translate([-(baseWidth/2-borderdistance),(baseHeight/2-borderdistance),0])
			hole();
		translate([-(baseWidth/2-borderdistance),-(baseHeight/2-borderdistance),0])
			hole();
	}
}

module base()
{
	translate([0,0,baseThickness/2])
		cube(size = [baseWidth,baseHeight,baseThickness], center = true);
}

module border()
{
	translate([0,0,baseThickness+letterthickness/2])
	linear_extrude(height = letterthickness, center = true, convexity = 10, twist = 0){
		translate([0,baseHeight/2-borderdistance,0])
			square ([baseWidth-borderdistance*2-borderradius*2+borderWidth*2,borderWidth],center = true);
		translate([0,-(baseHeight/2-borderdistance),0])
			square ([baseWidth-borderdistance*2-borderradius*2+borderWidth*2,borderWidth],center = true);
		translate([baseWidth/2-borderdistance,0,0])
			square ([borderWidth, baseHeight-borderdistance*2-borderradius*2+borderWidth*2,],center = true);
		translate([-(baseWidth/2-borderdistance),0,0])
			square ([borderWidth, baseHeight-borderdistance*2-borderradius*2+borderWidth*2,],center = true);

		translate([-(baseWidth/2-borderdistance),-(baseHeight/2-borderdistance),0])
			rotate(a=[0,0,0])
				quarter();
		translate([(baseWidth/2-borderdistance),(baseHeight/2-borderdistance),0])
			rotate(a=[0,0,180])
				quarter();
		translate([(baseWidth/2-borderdistance),-(baseHeight/2-borderdistance),0])
			rotate(a=[0,0,90])
				quarter();
		translate([-(baseWidth/2-borderdistance),(baseHeight/2-borderdistance),0])
			rotate(a=[0,0,270])
				quarter();
	}
}

module quarter()
{
	intersection() 
	{
		difference()
		{
			circle(r = borderradius, center=true, $fn=resolution);
			circle(r = borderradius-borderWidth, center=true, $fn=resolution);
		}
		square ([borderradius+1, borderradius+1],center = false);
	}
}

module hole()
{
	translate([0,0,baseThickness/2])
		cylinder(h = baseThickness+0.1, r = holediameter/2, $fn=resolution, center = true);
	translate([0,0,baseThickness-countersink])
		cylinder(h = countersink+0.1, r1 = holediameter/2, r2 = (holediameter+2*countersink)/2, $fn=resolution, center = false);
}