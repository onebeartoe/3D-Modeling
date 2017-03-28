this file shows the diff to get 'Mark - Music Instuctor' nametag.

1c1,6
<     
---
> 
> // this is pretty much a copy of name-tag.scad
> 
> use <../basics/rounded-edges/rounded-cube.scad>
> use <../shapes/chain-loop/chain-loop.scad>
>         
23c28
< leftIconType = "Bass Clef";    // [Rebel, Trooper, Aqua Dude, Cat, Spur, Mario, Luigi, Thundercat, Bass Clef, Treble Clef]
---
> leftIconType = "";//"Bass Clef";    // [Rebel, Trooper, Aqua Dude, Cat, Spur, Mario, Luigi, Thundercat, Bass Clef, Treble Clef]
25c30
< rightIconType = "Treble Clef"; // [Rebel, Trooper, Aqua Dude, Cat, Spur, Mario, Luigi, Thundercat, Bass Clef, Treble Clef]
---
> rightIconType = "";//"Treble Clef"; // [Rebel, Trooper, Aqua Dude, Cat, Spur, Mario, Luigi, Thundercat, Bass Clef, Treble Clef]
38d42
< 
40,43c44,47
< topText = "Mark";
< topTextYOffset = 7; // [0 : 30]
< topLetterSize = 19; // [2 : 25]
< topLetterSpacing = 1.5; // [1 : 10]
---
> topText = "tecolote";//"Mark";
> topTextYOffset = 0;//7; // [0 : 30]
> topLetterSize = 9.6;//19; // [2 : 25]
> topLetterSpacing = 1.05;//1.5; // [1 : 10]
46c50
< bottomText = "Music Instructor";
---
> bottomText = "";//Music Instructor";
52c56
< showBorder = "Yes"; // [Yes, No]
---
> showBorder = "No"; // [Yes, No]
58c62
< baseWidth=228;	// [228:600]	
---
> baseWidth = 46;//228;	// [228:600]	
61c65
< baseHeight=54;	// [54:150]
---
> baseHeight = 15;//54;	// [54:150]
78c82
< holes=4; 			// Choose 0,2 or 4 (others=0)
---
> holes = 0;//4; 			// Choose 0,2 or 4 (others=0)
93a98,99
> nametag();
> 
242a249,252
>     roundedCorners = true;
>     
>     size = [baseWidth, baseHeight, baseThickness];
>     
244,245c254,276
< 	translate([0,0,baseThickness/2])
< 		cube(size = [baseWidth,baseHeight,baseThickness], center = true);
---
>     translate([0,0,baseThickness/2])
>     if(roundedCorners)
>     {
>         roundedCube(size=size,cornerRadius=8, sides=30, sidesOnly=true, cubeCentered=true);
>     }
>     else
>     {
>         cube(size = size, center = true);
>     }
>     
>     chainLoop = true;
>     if(chainLoop)
>     {
>         x = 21;
>         y = 8;
>         z = 3;
>         xTranslate = -x / 2.0;
>         yTranslate = -baseHeight - 6;
>         translate([xTranslate,yTranslate,0])
>         chainLoop(xScale = x,
>                  yScale = y,
>                  zScale = z);
>     }
