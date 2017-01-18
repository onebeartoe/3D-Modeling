
/**
    Originally from: http://www.thingiverse.com/thing:1937473 
    Original Author: Geoff Buttsworth
    Original Filename: moneySpinner02
    Borrowed from Version: 0.5
    Twitter: @gbutts9

    This version is designed to work with the Thingiverse Customizer.
    Ref: http://customizer.makerbot.com/docs
*/

/*
    The knurled library is incorporated in toto here as Customizer is limited to one SCAD file.

	 * knurledFinishLib_v2.scad
	 * 
	 * Written by aubenc @ Thingiverse
	 *
	 * This script is licensed under the Public Domain license.
	 *
	 * http://www.thingiverse.com/thing:31122
	 *
	 * Derived from knurledFinishLib.scad (also Public Domain license) available at
	 *
	 * http://www.thingiverse.com/thing:9095
	 *
*/


/* [Spinner_Parameters] */
//Which coin do you want to use?
coin_list=8;//[1:AU $2,2:AU 5c,3:US 10c,4:UK £1,5:UK 5p,6:EU €1,7:QA 0.5QAR,8:US 5c]
coin=coin_list;

//How many spokes should the spinner have?
Number_of_Spokes=5;//[2,3,4,5,6,7]
spokeNumber=Number_of_Spokes;

//Flush for easier printing 
Flush_or_Raised_Hub=1;//[0:Hub,1:Flush]
flush=Flush_or_Raised_Hub;		//Flush is easier to print, the hub is height of bearing and may print with support

//knurledFinishLib_v2
	/*
	 * Usage:
	 *
	 *	 Drop this script somewhere where OpenSCAD can find it (your current project's
	 *	 working directory/folder or your OpenSCAD libraries directory/folder).
	 *
	 *	 Add the line:
	 *
	 *		use <knurledFinishLib_v2.scad>
	 *
	 *	 in your OpenSCAD script and call either...
	 *
	 *    knurled_cyl( Knurled cylinder height,
	 *                 Knurled cylinder outer diameter,
	 *                 Knurl polyhedron width,
	 *                 Knurl polyhedron height,
	 *                 Knurl polyhedron depth,
	 *                 Cylinder ends smoothed height,
	 *                 Knurled surface smoothing amount );
	 *
	 *  ...or...
	 *
	 *    knurl();
	 *
	 *	If you use knurled_cyl() module, you need to specify the values for all and
	 *
	 *  Call the module ' help(); ' for a little bit more of detail
	 *  and/or take a look to the PDF available at http://www.thingiverse.com/thing:9095
	 *  for a in depth descrition of the knurl properties.
	 */


	module knurl(	k_cyl_hg	= 12,
						k_cyl_od	= 25,
						knurl_wd =  3,
						knurl_hg =  4,
						knurl_dp =  1.5,
						e_smooth =  2,
						s_smooth =  0)
	{
	    knurled_cyl(k_cyl_hg, k_cyl_od, 
	                knurl_wd, knurl_hg, knurl_dp, 
	                e_smooth, s_smooth);
	}

	module knurled_cyl(chg, cod, cwd, csh, cdp, fsh, smt)
	{
	    cord=(cod+cdp+cdp*smt/100)/2;
	    cird=cord-cdp;
	    cfn=round(2*cird*PI/cwd);
	    clf=360/cfn;
	    crn=ceil(chg/csh);

	    echo("knurled cylinder max diameter: ", 2*cord);
	    echo("knurled cylinder min diameter: ", 2*cird);

		 if( fsh < 0 )
	    {
	        union()
	        {
	            shape(fsh, cird+cdp*smt/100, cord, cfn*4, chg);

	            translate([0,0,-(crn*csh-chg)/2])
	              knurled_finish(cord, cird, clf, csh, cfn, crn);
	        }
	    }
	    else if ( fsh == 0 )
	    {
	        intersection()
	        {
	            cylinder(h=chg, r=cord-cdp*smt/100, $fn=2*cfn, center=false);

	            translate([0,0,-(crn*csh-chg)/2])
	              knurled_finish(cord, cird, clf, csh, cfn, crn);
	        }
	    }
	    else
	    {
	        intersection()
	        {
	            shape(fsh, cird, cord-cdp*smt/100, cfn*4, chg);

	            translate([0,0,-(crn*csh-chg)/2])
	              knurled_finish(cord, cird, clf, csh, cfn, crn);
	        }
	    }
	}

	module shape(hsh, ird, ord, fn4, hg)
	{
		x0= 0;	x1 = hsh > 0 ? ird : ord;		x2 = hsh > 0 ? ord : ird;
		y0=-0.1;	y1=0;	y2=abs(hsh);	y3=hg-abs(hsh);	y4=hg;	y5=hg+0.1;

		if ( hsh >= 0 )
		{
			rotate_extrude(convexity=10, $fn=fn4)
			polygon(points=[	[x0,y1],[x1,y1],[x2,y2],[x2,y3],[x1,y4],[x0,y4]	],
						paths=[	[0,1,2,3,4,5]	]);
		}
		else
		{
			rotate_extrude(convexity=10, $fn=fn4)
			polygon(points=[	[x0,y0],[x1,y0],[x1,y1],[x2,y2],
									[x2,y3],[x1,y4],[x1,y5],[x0,y5]	],
						paths=[	[0,1,2,3,4,5,6,7]	]);
		}
	}

	module knurled_finish(ord, ird, lf, sh, fn, rn)
	{
	    for(j=[0:rn-1])
	    assign(h0=sh*j, h1=sh*(j+1/2), h2=sh*(j+1))
	    {
	        for(i=[0:fn-1])
	        assign(lf0=lf*i, lf1=lf*(i+1/2), lf2=lf*(i+1))
	        {
	            polyhedron(
	                points=[
	                     [ 0,0,h0],
	                     [ ord*cos(lf0), ord*sin(lf0), h0],
	                     [ ird*cos(lf1), ird*sin(lf1), h0],
	                     [ ord*cos(lf2), ord*sin(lf2), h0],

	                     [ ird*cos(lf0), ird*sin(lf0), h1],
	                     [ ord*cos(lf1), ord*sin(lf1), h1],
	                     [ ird*cos(lf2), ird*sin(lf2), h1],

	                     [ 0,0,h2],
	                     [ ord*cos(lf0), ord*sin(lf0), h2],
	                     [ ird*cos(lf1), ird*sin(lf1), h2],
	                     [ ord*cos(lf2), ord*sin(lf2), h2]
	                    ],
	                triangles=[
	                     [0,1,2],[2,3,0],
	                     [1,0,4],[4,0,7],[7,8,4],
	                     [8,7,9],[10,9,7],
	                     [10,7,6],[6,7,0],[3,6,0],
	                     [2,1,4],[3,2,6],[10,6,9],[8,9,4],
	                     [4,5,2],[2,5,6],[6,5,9],[9,5,4]
	                    ],
	                convexity=5);
	         }
	    }
	}

	module knurl_help()
	{
		echo();
		echo("    Knurled Surface Library  v2  ");
	   echo("");
		echo("      Modules:    ");
		echo("");
		echo("        knurled_cyl(parameters... );    -    Requires a value for each an every expected parameter (see bellow)    ");
		echo("");
		echo("        knurl();    -    Call to the previous module with a set of default parameters,    ");
		echo("                                  values may be changed by adding 'parameter_name=value'        i.e.     knurl(s_smooth=40);    ");
		echo("");
		echo("      Parameters, all of them in mm but the last one.    ");
		echo("");
		echo("        k_cyl_hg       -   [ 12   ]  ,,  Height for the knurled cylinder    ");
		echo("        k_cyl_od      -   [ 25   ]  ,,  Cylinder's Outer Diameter before applying the knurled surfacefinishing.    ");
		echo("        knurl_wd     -   [   3   ]  ,,  Knurl's Width.    ");
		echo("        knurl_hg      -   [   4   ]  ,,  Knurl's Height.    ");
		echo("        knurl_dp     -   [  1.5 ]  ,,  Knurl's Depth.    ");
		echo("        e_smooth   -    [  2   ]  ,,  Bevel's Height at the bottom and the top of the cylinder    ");
		echo("        s_smooth   -    [  0   ]  ,,  Knurl's Surface Smoothing :  File donwn the top of the knurl this value, i.e. 40 will snooth it a 40%.    ");
		echo("");
	}

//Allocate coin data

	coinName=coin==1 ? "AU $2" : 
		(coin==2 ? "AU 5c" : 
			(coin==3 ? "US 10c" :
				(coin==4 ? "UK £1" :
					(coin==5 ? "UK 5p" :
						(coin==6 ? "EU €1" :
							(coin==7 ? "QA 0.5QAR" : "US 5c")
						)	
					)	
				)
			)
		);

	coin_d=coin==1 ? 20.5 : 
		(coin==2 ? 19.4 : 
			(coin==3 ? 17.9 :
				(coin==4 ? 22.5 :
					(coin==5 ? 18.0 :
						(coin==6 ? 23.3 :
							(coin==7 ? 25.0 : 21.3)
						)
					)	
				)
			)
		);

	coin_z=coin==1 ? 2.8 : 
		(coin==2 ? 1.3 : 
			(coin==3 ? 1.35 :
				(coin==4 ? 3.15 :
					(coin==5 ? 1.8 :
						(coin==6 ? 2.35 :
							(coin==7 ? 1.78 : 1.95)
						)
					)	
				)
			)
		);

	stack=coin==2 ? 3 : 
		(coin==3 ? 3 : 
			(coin==5 ? 3 :
				(coin==7 ? 3 :
					(coin==8 ? 4 : 2)
				)
			)	
		);

//Default values
	$fa=0.8;
	$fs=0.8;

//Variables:

	rim=5;
	holder_d=coin_d+rim;
	holder_z=coin_z*stack;

	brg_d=22.0;
	brg_z=7.0;

	spoke_x=coin_d/2;
	spoke_y=coin_d/3;
	spoke_z=holder_z;

	//If flush: hub will be height of coin stack otherwise height of bearing
	hub_z=flush==1 ? coin_z*stack : brg_z;	

//SpinnerModules

	module dollarHolder() {
		translate([0,coin_d/2+spoke_y,0])
		difference() {
			translate([0,0,-coin_z*stack/2])
				knurl(k_cyl_hg=holder_z,k_cyl_od=holder_d);
				
			xyScale = 0.75;
			translate([0, 0, -5])
			scale([xyScale, xyScale, 1])
			starThumbnail(height=10);
//			cylinder(d=coin_d,h=holder_z+4,center=true);
		}	
	}

	module hub() {
			cylinder(h=hub_z,d=brg_d+rim,center=true);
	}

	module spoke() {
		translate([0,spoke_y/2,0])
			cube([spoke_x,spoke_y,spoke_z], center=true);
	}

	module brgVoid() {
		cylinder(h=brg_z+2,d=brg_d,center=true);
	}

	module holderSpoke() {
		translate([0,brg_d/2,0])
		union() {
			dollarHolder();
			spoke();
		}
	}

//Rotate
	rA = 360/spokeNumber;	//rotational angle
	fA = round(360-rA);		//final angle

	module spinner() {
		for (i = [0:rA:fA]) {
			rotate([0,0,i])
				holderSpoke();
		}
	}

//Finalise
	module plus() {
		hub();
		spinner();
	}

	module minus() {
		brgVoid();
	}

	//Render
	difference() {
		plus();
		minus();
	}

// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

module star(h=1)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[9.080000,-22.000000],[10.922500,-17.093750],[12.213125,-14.728281],[13.890000,-13.020000],[15.773906,-12.298125],[18.041250,-12.022500],[22.500000,-11.910000],[34.390000,-10.968750],[40.862812,-10.133906],[45.500000,-9.000000],[28.500000,4.610000],[21.270000,12.170000],[22.870000,22.000000],[27.500000,43.000000],[8.500000,31.580000],[-0.500000,27.200000],[-10.500000,32.320000],[-28.500000,43.000000],[-22.870000,21.000000],[-21.690000,11.090000],[-28.500000,4.130000],[-45.500000,-11.000000],[-11.500000,-13.000000],[-0.500000,-43.000000],[2.289219,-38.828594],[4.908750,-33.096250],[9.080000,-22.000000]]);
  }
}

module starThumbnail(height = 1)
{
	xyScale = 0.9544;
	scale([xyScale, xyScale, height])
	star();	
}