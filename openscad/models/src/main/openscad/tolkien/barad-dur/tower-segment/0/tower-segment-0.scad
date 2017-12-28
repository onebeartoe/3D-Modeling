
use <../tower-segment.scad>
use <../../window-of-the-eye/window-of-the-eye.scad>

/**
 * This is the top most tower segment
 */
module baradDur_towerSegment_0(brackets = false)
{
	union()
	{
		baradDur_towerSegment(bottomRadius = baradDur_towerSegment_0_bottomRadius(),
						  topRadius = baradDur_towerSegment_0_topRadius(),
						  zLength=baradDur_towerSegment_zLength() );

        if(brackets)
		{
			baradDur_towerSegment_0_brackets();
		}
	}
}

/** Support functions and modules follow. **/

function baradDur_towerSegment_0_bottomRadius() = baradDur_towerSegment_0_topRadius() + towerSegment_girthIncrement();

function baradDur_towerSegment_0_topRadius() = 32;

module baradDur_towerSegment_0_bracket(yLength)
{
    difference()
	{
		cube_xLength = 6;
		cube_yLength = yLength + 4;
		translate([0,-1,0])
		cube([cube_xLength,
			  cube_yLength,
			  5]);

		cutoutXY = yLength + 0.8;
		color("green")
		translate([-0.01,
					cutoutXY - 4,
					0])
		cube([cube_yLength + 1,
			  cutoutXY,
			  cutoutXY]);
	}
}

module baradDur_towerSegment_0_brackets()
{
	yLength = windowOfTheEye_attachmentNub_xLength();
	color("orange")
	translate([0,
			   baradDur_towerSegment_0_topRadius() - (yLength * 2) - 0.8,
			   baradDur_towerSegment_zLength()])
	baradDur_towerSegment_0_bracket(yLength = yLength);

	translate([0,
			   -baradDur_towerSegment_0_topRadius() + yLength - 0.75,
			   baradDur_towerSegment_zLength()])
	baradDur_towerSegment_0_bracket(yLength = yLength);
}
