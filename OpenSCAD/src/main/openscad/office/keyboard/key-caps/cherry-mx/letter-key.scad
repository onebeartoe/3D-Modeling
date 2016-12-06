
blankStl = "C:\\home\\world\\versioning\\beto-land-world\\3d-printing\\office\\keyboard\\Cherry-MX-KeyCaps\\adafruit\\blank-key.stl";
blankStl = "blank-key.stl";

xLowercaseOffset = -37;
xUppercaseOffset = xLowercaseOffset - 0.5;

//aphabetCaps();
//keyCapString(["H"], xUppercaseOffset);
uppercaseAphabetCaps();

module aphabetCaps()
{
	alphabet = ["a", "b", "c", "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	
	keyCapString(alphabet, xLowercaseOffset);
}

module keyCapString(keyString, xOffset)
{
	strlen = len(keyString); 
	echo("count: ", strlen);
	
	for(i = [0 : strlen-1])
	{
		echo(i);
		l = keyString[i];
		translate([i*30, 0, 0])
		oneAlphanumericKey(l, xOffset);
	}
}

module oneAlphanumericKey(letter, xOffset)
{
	echo(letter);
	
	union()
	{
		font = "Arial:style=Bold";
		fontSize = 7.5;
		color("blue")
		translate([xOffset, 1, 9.5])
		linear_extrude(height=2)
		text(letter, font = font, size=fontSize);
		
		translate([0, 0, 11])
		rotate([180,0,0])
		import(blankStl);
	}	
}

module uppercaseAphabetCaps()
{
	alphabet = ["A", "B", "C", "D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
	xOffset = xUppercaseOffset;
	
	keyCapString(alphabet, xOffset);
}
