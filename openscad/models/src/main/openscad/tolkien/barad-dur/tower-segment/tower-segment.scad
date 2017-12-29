
module baradDur_towerSegment(bottomRadius,
							 electronicsCutouts = false,
							 topRadius,
							 zLength)
{
	color("gray")
	difference()
	{
    	cylinder(h=zLength, r1=bottomRadius, r2=topRadius, $fn=40);

		translate([0, 0, -0.01])
		cylinder(r=topRadius - 8.5, h=zLength + 0.02);//, center=true);

		if(electronicsCutouts == true)
		{
			echo("yue");
			rotate([0, 0, -90])
			baradDur_towerSegment_electronicsCutouts();
		}
		else
		{
			echo("narto");
		}
	}
}

/** Support functions and modules follow. **/

module baradDur_towerSegment_electronicsCutouts()
{
	baradDur_towerSegment_electronicsCutouts_switch();
	baradDur_towerSegment_electronicsCutouts_usb();
}

module baradDur_towerSegment_electronicsCutouts_switch()
{
	xLength = 50;
	yLength = 12;
	zLength = 5;
	translate([0, 0, 35])
	cube([xLength, yLength, zLength]);
}

module baradDur_towerSegment_electronicsCutouts_usb()
{
	// USB cable cutout
	xLength = 50;
	yLength = 11;
	zLength = 22;
	translate([0,0,-0.01])
	cube([xLength, yLength, zLength]);
}

function towerSegment_girthIncrement() = 2.5;

function baradDur_towerSegment_zLength() = 50;
