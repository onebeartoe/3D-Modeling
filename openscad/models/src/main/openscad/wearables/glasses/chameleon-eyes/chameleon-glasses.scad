
use <../../../external-resources/toys/fidget-spinners/nested-rings/switchborg/nested-rings.scad>
use <../../../external-resources/toys/fidget-spinners/nested-rings/switchborg/parameterized/parameterized-nested-rings.scad>

use <../../../shapes/open-cylinder/open-cylinder.scad>

module chameleonGlasses(noseBridge_xLength = 25)
{
	union()
	{
	    stockNestedRings();

		outer_radius = stockNestedRings_outerRadius();

		step = stockNestedRings_step();

		ring_count = stockNestedRings_ringCount();

		xTranslate = outer_radius
					 + (stockNestedRings_biconeGap() + step) * ring_count
					 + noseBridge_xLength;

	    translate([xTranslate,0,0])
	    stockNestedRings();

		chameleonGlasses_noseBridge(noseBridge_xLength, outer_radius);
	}
}

module chameleonGlasses_noseBridge(noseBridge_xLength, lenseOuterRadius)
{
	height = 10;
	outerRadius = noseBridge_xLength / 2.0
				  + 4;

	rotation = [90,0,0];

	xTranslate = lenseOuterRadius + (noseBridge_xLength / 2.0);
	yTranslate = height / 2.0;
	zTranslate = -outerRadius / 2.0 -5;

	translation = [xTranslate, yTranslate, zTranslate];

	difference()
	{
		translate(translation)
		rotate(rotation)
		openCylinder(height = height,
					 innerRadius = outerRadius - 4,
					 outerRadius = outerRadius);

	    xLength = noseBridge_xLength + 16;
		yLength = 20;
		zLength = outerRadius + 20;
		cutout = [xLength, yLength, zLength];

		cutoutTranslationX =   (xLength / 2.0) + 5 ;
		cutoutTranslationY = -height;
		cutoutTranslationZ = - (stockNestedRings_ringWidth() / 2.0) - (zLength);
		cutoutTranslation = [cutoutTranslationX, cutoutTranslationY, cutoutTranslationZ];

		chameleonGlasses_noseBridgeCutout(cutout = cutout, translation = cutoutTranslation);
	}
}

module chameleonGlasses_noseBridgeCutout(cutout, translation)
{
	translate(translation)
	cube(cutout);
}
