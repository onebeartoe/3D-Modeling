
/**
 * buttonSide - the length of the side of the rectangular cutout for the button/key
 */
module keyboardSwitchMountingHoles(buttonCount = 4,
			 buttonSide = 5,
		 	 panelHeight = 1)
{
	x = 0;
	startY = 0;

	ySpacing = 3;
	yIncrement = buttonSide + ySpacing;

        union()
        {
            for(i = [0 : buttonCount-1])
            {
                    y = startY + (i * yIncrement);

                    zLength = 2 * panelHeight + 0.2;

                    color("green")
                    translate([x, y, -0.1])
                    cube([buttonSide, buttonSide, zLength]);
            }
        }
}
