
use <../../../../external-resources\music\notes\bass-clef\bass-clef.scad>
use <../../../../external-resources\music\notes/treble-clef/treble-clef-scaled-down.scad>

module aphabetKeycaps(xOffset, font)
{
	alphabet = ["a", "b", "c", "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	
	keyCapString(alphabet, xOffset, font);
}

module blankKey()
{
	blankStl = "blank-key.stl";
	translate([0, 0, 11])
	rotate([180,0,0])
	import(blankStl);	
}

module iconKeycap(name, xOffset, yOffset)
{
	union()
	{
//		name = "Bass Clef";
		xyScale = 0.4;
		translate([0, 1, 9.5])
		oneIcon(iconType=name, iconXyScale=xyScale, iconHeight=1, 
			    xOffset=xOffset, yOffset=yOffset, iconColor="green");
		
		blankKey();
	}
}

module iconKeycapDemo()
{
	iconKeycap("Bass Clef", xOffset=-34, yOffset=2);
	
	rowSpacing = 30;
	translate([rowSpacing, 0, 0])
	iconKeycap("Treble Clef", xOffset=-34, yOffset = 2);	
}

module keyCapString(keyString, xOffset, font)
{
	strlen = len(keyString); 
	
	for(i = [0 : strlen-1])
	{
		l = keyString[i];
		translate([i*30, 0, 0])
		oneAlphanumericKey(l, xOffset, font);
	}
}

module oneAlphanumericKey(letter, xOffset, font)
{	
	union()
	{
		fontSize = 7.5;
		color("blue")
		translate([xOffset, 1, 9.5])
		linear_extrude(height=2)
		text(letter, font=font, size=fontSize);
		
		blankKey();
	}	
}

module oneIcon(iconType, iconXyScale, iconHeight, xOffset, yOffset, iconColor)
{
    color(iconColor)
    translate([xOffset, yOffset, 0])
    scale([iconXyScale, iconXyScale, iconHeight])
    if(iconType == "Bass Clef")
    {
    	bassClefThumbnail();
    }
	else if(iconType== "Treble Clef")
	{
		trebleClefScaledDownThumbnail();
	}
    else
    {
        echo("drawing no icons");
    }
}	

module uppercaseAphabetCaps(xOffset, font)
{
	alphabet = ["A", "B", "C", "D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
	
	keyCapString(alphabet, xOffset, font);
}
