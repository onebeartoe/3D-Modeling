
use <../../../../external-resources/cat/cat.scad>
use <../../../../external-resources/batman/batman.scad>
use <../../../../external-resources/plumber-brother/luigi-outline.scad>
use <../../../../external-resources/music/notes/bass-clef/bass-clef.scad>
use <../../../../external-resources/music/notes/treble-clef/treble-clef-scaled-down.scad>
use <../../../../external-resources/oshw/oshw-logo-800-px.scad>
use <../../../../external-resources/rebel-alliance/rebel-alliance.scad>
use <../../../../shapes/heart/heart.scad>
use <../../../../shapes/star/star.scad>
use <../../../../external-resources/thundercats/thundercats-logo.scad>
use <../../../../external-resources/trooper/scrum-trooper.scad>

use <blank-keycap.scad>

module aphabetKeycaps(xOffset, font)
{
	alphabet = ["a", "b", "c", "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	
	keyCapString(alphabet, xOffset, font);
}

module blankKey()
{
//	translate([0, 0, 11])
//	rotate([180,0,0])
	blankKeycap();
}

module iconKeycap(name, xOffset, yOffset, xyScale, iconColor, iconHeight=1)
{
	union()
	{
		translate([0, 1, 9.5])
		oneIcon(iconType=name, iconXyScale=xyScale, iconHeight=iconHeight, xOffset=xOffset, yOffset=yOffset, iconColor="green");
		
		blankKey();
	}
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
    else if(iconType == "Batman")
    {
    	batmanLogoThumbnail();
    }
    else if(iconType == "Cat")
    {
    	catThumbnail();
    }
    else if(iconType == "Heart")
    {
    	heartThumbnail();
    }
	else if(iconType == "Luigi")
	{
		luigiThumbnail();
	}
	else if(iconType == "OSHW")
	{
		oshwLogoThumbnail();
	}
	else if(iconType == "Rebel")
	{
		rebelAllianceThumbnail();
	}    
    else if(iconType == "Star")
    {
    	starThumbnail();
    }    
	else if(iconType== "Treble Clef")
	{
		trebleClefScaledDownThumbnail();
	}
	else if(iconType == "Trooper")
	{
		scrumTrooperThumbnail();
	}
	else if(iconType == "Thundercat")
	{
		thundercatsLogoThumbnail();
	}
    else
    {
        echo("drawing no icons", iconType);
    }
}	

module uppercaseAphabetCaps(xOffset, font)
{
	alphabet = ["A", "B", "C", "D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
	
	keyCapString(alphabet, xOffset, font);
}
