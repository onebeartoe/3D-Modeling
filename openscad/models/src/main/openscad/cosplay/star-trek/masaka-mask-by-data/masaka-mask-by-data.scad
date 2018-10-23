

use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>

masakasMask();

module masakasMask()
{
	rightEdge_x = 53;

	topRadius = rightEdge_x + 20;

	difference()
	{
		masakasMask_solid(topRadius, rightEdge_x);

		masakasMask_cutouts(topRadius, rightEdge_x);
	}
}

// support modules follow

module masakasMask_bottom(rightEdge_x)
{
	masakasMask_cheekFlap();

	xTranslate = rightEdge_x * 2;
	zTranslate = 1;

	// the mirrored cheek flap
	translate([xTranslate, 0, zTranslate])
	rotate([0,180,0])
	masakasMask_cheekFlap();

}

module masakasMask_cheekFlap()
{
	minkowski()
	{
		linear_extrude(height=1, scale=[1,1], slices=20, twist=0)
		polygon(points=
		[
			[5,0],

			[15,-15],

			[30,-5],

			[35, 20],

			// inner cheek area
			[38, 23],

			// nose bridge
			[48, 25], [53, 27],

			// right edge
			[53, 40],

			// outer cheek
			[25, 28]

		]);

	    sphere(r=1, $fn=10);
	}
}

module masakasMask_cutouts(topRadius, rightEdge_x)
{
	masakasMask_EyeCutouts(rightEdge_x);

	// bottom flattener
	translate([0,0, -1.7])
	cube([400, 400, 2], center= true);
}

module masakasMask_EyeCutouts(rightEdge_x)
{
	xTranslateOffset = 22;

	xTranslate = rightEdge_x - xTranslateOffset;
	yTranslate = 34;

	translate([xTranslate, yTranslate, -15])
	masakasMask_LeftEyeCoutout();

	// right eye mirrored from left
	rightEye_xTranslate = rightEdge_x + xTranslateOffset;
	translate([rightEye_xTranslate, yTranslate, 20])
	rotate([0,180,0])
	masakasMask_LeftEyeCoutout();
}

module masakasMask_LeftEyeCoutout(rightEdge_x)
{
	minkowski()
	{
		linear_extrude(height=50, scale=[1,1], slices=20, twist=0)
		polygon(points=
		[
			// below the first direction is the side, second direction is the orientation on that side

			// top left
			[0,0],

			// left bottom
			[4,-6],

			// bottom right
			[11,-6],

			// diagnal top
			[14, -4],

			// right top
			[12, 0.5]

		]);

		cylinder(r=1, $fn=30);
	}
}

module masakasMask_solid(topRadius, rightEdge_x)
{
	union()
	{
		translate([rightEdge_x, 51, 4])
		rotate([-18, 0, 0])
		masakasMask_sunEmblem();

		masakasMask_top(radius = topRadius,
						rightEdge_x = rightEdge_x);

		masakasMask_bottom(rightEdge_x = rightEdge_x);
	}
}

module masakasMask_sunEmblem()
{
	innerRadius = 5;
	minkowskiSphereRadius = 2;
	outerRadius = 6;

	roundDoughnut(height = 1,
				  innerRadius = innerRadius,
		  		  minkowskiSphereRadius = minkowskiSphereRadius,
			      outerRadius = outerRadius);

    ringRadius = outerRadius + minkowskiSphereRadius;

	difference()
	{
		masakasMask_sunEmblemLines(ringRadius = ringRadius);

		cylinder(r = innerRadius,
				 h = 10,
				 center = true);
	}
}

module masakasMask_sunEmblemSingleLine(height, radius)
{
color("green")
translate([height, 0 , 0])
sphere(r = radius,
	   $fn = fn);

	fn = 15;
	color("green")
	rotate([0,90,0])
	cylinder(h = height,
			 r = radius,
			 $fn = fn);

	 // other end cap
	 color("green")
	 translate([0, 0 , 0])
	 sphere(r = radius,
	 		$fn = fn);
}

module masakasMask_sunEmblemLines()
{
	translate([0, 0, 1.2])
	masakasMask_sunEmblemCrossLines(height = 28,
									radius = 0.5,
									yTranslate = 1.2);

    // diagnalLines
	translate([0, 0, 1])
	rotate([0, 0, 45])
	masakasMask_sunEmblemCrossLines(height = 24,
									radius = 1.2,
									yTranslate = 2);
}

module masakasMask_sunEmblemCrossLines(height,
									   radius,
									   yTranslate)
{
//TODO where is this used?
	ringRadius = 7;

	xTranslate = -(height / 2.0 ) ;

	translate([xTranslate, yTranslate, 0])
	masakasMask_sunEmblemSingleLine(height = height,
							  radius = radius);

    translate([xTranslate, -yTranslate, 0])
    masakasMask_sunEmblemSingleLine(height = height,
	  						  radius = radius);

    vertical_xTranslate = -yTranslate;
	vertical_yTranslate = xTranslate;

	translate([vertical_xTranslate, vertical_yTranslate, 0])
    rotate([0, 0, 90])
    masakasMask_sunEmblemSingleLine(height = height,
  						  	  radius = radius);

    translate([-vertical_xTranslate, vertical_yTranslate, 0])
    rotate([0, 0, 90])
    masakasMask_sunEmblemSingleLine(height = height,
						  	  radius = radius);
}

module masakasMask_top(radius, rightEdge_x)
{
	cube_zLength = 10;

	xTranslate = rightEdge_x;
	yTranslate = 29;
	zTranslate = -radius + cube_zLength - 0.450;

	translate([xTranslate, yTranslate, zTranslate])

	difference()
	{
		sphere(r = radius, $fn = 60);

		// xy plane cutout
		translate([0, 0, -10])
		cube([400, 400, 145], center=true);

		// xz plane cutout
		color("green")
		translate([0, -radius/2.0, -10])
		cube([190, radius, 190], center=true);
	}
}
