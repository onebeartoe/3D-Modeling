
// ************* Credits part *************

//  This was origianllay named uploads-b4-df-a6-25-4b-AnyNameSign.scad and came from 
//
//		http://www.thingiverse.com/thing:16193
//
//  Programmed by Fryns - March 2014


// Adapted by Roberto Marquez - onebeartoe - 2015

// Uses Write.scad by HarlanDMii, published on Thingiverse 18-Jan-2012 (thing:16193)	 

// ************* Declaration part *************

resolution=50; 	// Use 20 for draft 100 for nice
basex=228;			// Width of base
basey=54;			// Height of base
basethickness=2;

borderwidth=2;
borderradius=8;
borderdistance=5;	// Distance from edge

holediameter=3;
countersink=2;
holes=4; 			// Choose 0,2 or 4 (others=0)

letterthickness=1;
lettersize=12 ;

font="orbitron.dxf"; 		// BlackRose.dxf, orbitron.dxf, Letters.dxf

namematrix =              
[					 	  // Matrix with place and names - add as many rows as you like	 
	[10,"Roberto"],	      //[Y-placement, "Name"],      note: Y-placement of center of text 
	[-10,"Scrum Trooper"],	  //[Y-placement, "Name"]      note: Y-placement of center of text 	
];

// ************* Executable part *************
use <Write.scad>	// remember to download write.scad and fonts

nametag_assembly();


// ************* Module part *************

module nametag_assembly() 
{
	color("black") 
	writing();
	
//TODO: put an if conditional here that determins if the border is displayed or not	
	color("black")	
	border();
	
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
			translate([0,namematrix[i][0],basethickness+letterthickness/2])
			write(namematrix[i][1],t=letterthickness,h=lettersize,center=true,font=font);
		}
	}
}

module base2holes() 
{
	difference()
	{
		base();
		translate([-(basex/2-borderdistance*2-borderwidth-countersink-holediameter),0,0])
			hole();
		translate([(basex/2-borderdistance*2-borderwidth-countersink-holediameter),(0),0])
			hole();
	}
}

module base4holes() 
{
	difference(){
		base();
		translate([(basex/2-borderdistance),(basey/2-borderdistance),0])
			hole();
		translate([(basex/2-borderdistance),-(basey/2-borderdistance),0])
			hole();
		translate([-(basex/2-borderdistance),(basey/2-borderdistance),0])
			hole();
		translate([-(basex/2-borderdistance),-(basey/2-borderdistance),0])
			hole();
	}
}

module base()
{
	translate([0,0,basethickness/2])
		cube(size = [basex,basey,basethickness], center = true);
}

module border()
{
	translate([0,0,basethickness+letterthickness/2])
	linear_extrude(height = letterthickness, center = true, convexity = 10, twist = 0){
		translate([0,basey/2-borderdistance,0])
			square ([basex-borderdistance*2-borderradius*2+borderwidth*2,borderwidth],center = true);
		translate([0,-(basey/2-borderdistance),0])
			square ([basex-borderdistance*2-borderradius*2+borderwidth*2,borderwidth],center = true);
		translate([basex/2-borderdistance,0,0])
			square ([borderwidth, basey-borderdistance*2-borderradius*2+borderwidth*2,],center = true);
		translate([-(basex/2-borderdistance),0,0])
			square ([borderwidth, basey-borderdistance*2-borderradius*2+borderwidth*2,],center = true);

		translate([-(basex/2-borderdistance),-(basey/2-borderdistance),0])
			rotate(a=[0,0,0])
				quarter();
		translate([(basex/2-borderdistance),(basey/2-borderdistance),0])
			rotate(a=[0,0,180])
				quarter();
		translate([(basex/2-borderdistance),-(basey/2-borderdistance),0])
			rotate(a=[0,0,90])
				quarter();
		translate([-(basex/2-borderdistance),(basey/2-borderdistance),0])
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
			circle(r = borderradius-borderwidth, center=true, $fn=resolution);
		}
		square ([borderradius+1, borderradius+1],center = false);
	}
}

module hole()
{
	translate([0,0,basethickness/2])
		cylinder(h = basethickness+0.1, r = holediameter/2, $fn=resolution, center = true);
	translate([0,0,basethickness-countersink])
		cylinder(h = countersink+0.1, r1 = holediameter/2, r2 = (holediameter+2*countersink)/2, $fn=resolution, center = false);
}