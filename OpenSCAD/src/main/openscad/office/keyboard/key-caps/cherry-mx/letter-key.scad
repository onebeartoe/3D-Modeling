
module aphabetCaps(xOffset, font)
{
	alphabet = ["a", "b", "c", "d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	
	keyCapString(alphabet, xOffset, font);
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
		
		blankStl = "blank-key.stl";
		translate([0, 0, 11])
		rotate([180,0,0])
		import(blankStl);
	}	
}

module uppercaseAphabetCaps(xOffset, font)
{
	alphabet = ["A", "B", "C", "D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
	
	keyCapString(alphabet, xOffset, font);
}
