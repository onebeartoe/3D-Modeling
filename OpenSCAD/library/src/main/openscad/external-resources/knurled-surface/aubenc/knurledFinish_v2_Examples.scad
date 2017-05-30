/*
 * knurledFinish_v2_Examples.scad
 * 
 * Written by aubenc @ Thingiverse
 *
 * This script is licensed under the Public Domain license.
 *
 * http://www.thingiverse.com/thing:31122
 *
 */

use <knurledFinishLib_v2.scad>

/* ************************** Examples ****************************************** */


/* ****************************************************************************** */
// Example 00: Brief help, available modules and parameters.
//
//	knurl_help();


/* ****************************************************************************** */
// Example 01: A knurled cylinder generated with the default parameters.
//
//	knurl();


/* ****************************************************************************** */
// Example 02: Changing the Height and the Outer Diameter from the default values.
//
//	knurl(k_cyl_hg	= 40,	k_cyl_od	= 15);


/* ****************************************************************************** */
// Example 03: Not intended to be printed but to be used in a boolean difference.
//             Setting a negative value to the Ends Smoothing Height value.
//	            This will change the shape by embossing the bevel instead of
//             carving it. Also, the final shape is extended 0.1mm at the
//             top and the bottom.
//
//	translate([0,0,0.1]) knurl(e_smooth=-1);


/* ****************************************************************************** */
// Example 04: A use for "Example 03"...
//
//	knurl_example_04();

module knurl_example_04()
{
	tk=1.2;			// Minimum thickness of the cylinder.
						//		(at the carved tip of the knurls)
	rd=26.5/2+tk;	// Radius for the cylinder. 
						//		(from knurled cyl max diameter echoed by the library)
	hg=12;			// Default value for the knurled cylinder height 
                  //    (we'll use to ensure the same height fort both cylinders) 
	es=2;				// Default Ends Smoothing value used by 'knurl()' in the library.
						//		(this is also the half of the knurl height so the "bevel"
                  //     will cut in a "clean" edge of the knurl texture)

	difference()
	{
		cylinder(h=hg, r=rd, $fn=4*rd*PI, center=false);

		knurl(e_smooth=-es);
	}
}


/* ****************************************************************************** */
// Example 05: A more elaborated use for "Example 03"...
//             It turns out that the knurl library "is optimized" for outer
//             knurled surfaces. Using this thing for inner knurled textures
//             may result in a "not so good looking" output.
//             In this example we use shorter cylinder 
//
//	knurl_example_05();

module knurl_example_05()
{
	tk=1.2;			// Minimum thickness of the cylinder.
						//		(at the carved tip of the knurls)
	rd=26.5/2+tk;	// Radius for the cylinder. 
						//		(from knurled cyl max diameter echoed by the library)
	hg=12;			// Default Cylinder Height value used by 'k_cyl()' in the library.
						//		(we'll use it here to trim the final cylinder)
	es=2;				// Default Ends Smoothing value used by 'k_cyl()' in the library.
						//		(also to be used to trim the final cylinder)

	difference()
	{
		cylinder(h=hg-es, r=rd, $fn=4*rd*PI, center=false);

		translate([0,0,-es/2])
		knurl(e_smooth=-es);
	}
}


/* ****************************************************************************** */
// Example 06: A difference between 2 knurled cylinders.
//					The wall thickness remains constant.
//
//	knurl_example_06(1.2);	// Parameter is the wall thickness

module knurl_example_06(tk)
{
	s_outer=(26.5+tk)/26.5;
	s_inner=(26.5-tk)/26.5;

	difference()
	{
		scale([s_outer,s_outer,1]) knurl(s_smooth=50);

		scale([s_inner,s_inner,1]) knurl(s_smooth=50);

		// Uncomment the following line to se a section cut of the thing...
		// translate([0,-50,0]) cube(size=[100,100,100], center=true);
	}
}


/* ****************************************************************************** */
// Example 07: Another difference between 2 knurled cylinders.
//					This time we use the new inner suface finish that applies
//					the bevel and the surface smooth in a different way.
//
//	knurl_example_07(1.2);	// Parameter is the minimum wall thickness

module knurl_example_07(tk)
{
	fd=25;		// Final Diameter = knurl() defaulf diameter size
					//		(this will become the middle diameter for the ring)

	s_outer=(fd+tk)/24.4;
	s_inner=(fd-tk)/27.1;

	difference()
	{
		scale([s_outer,s_outer,1]) knurl(s_smooth=60);

		scale([s_inner,s_inner,1]) knurl(e_smooth=-2, s_smooth=40);

		// Uncomment the following line to se a section cut of the thing...
		//	translate([0,-50,0]) cube(size=[100,100,100], center=true);
	}
}


/* *********** Examples End ***************************************************** */

//	examples_plates(p=2);

module examples_plates(p=0)
{
	if( p == 1 )
	{
		translate([-22,16,0  ]) knurl();

		translate([  0,4,0  ]) knurl(k_cyl_hg	= 40,	k_cyl_od	= 15);

		translate([ 22,16,0.1]) knurl(e_smooth=-1);

		translate([-17,-14,0 ]) knurl_example_04();

		translate([ 17,-14,0 ]) knurl_example_05();
	}
	else if( p == 2 )
	{
		translate([-16,0,0 ]) knurl_example_06(1.2);

		translate([ 16,0,0 ]) knurl_example_07(0.7);
	}
	else
	{
		echo("Nothing to compile...");
	}
}
