
use <../tower-segment.scad>

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
			echo("farto");
		}
	}
}

/** Support functions and modules follow. **/

function baradDur_towerSegment_0_bottomRadius() = baradDur_towerSegment_0_topRadius() + towerSegment_girthIncrement();

function baradDur_towerSegment_0_topRadius() = 30;
