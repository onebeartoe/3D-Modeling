
use <pencil-holder.scad>;

// this determines how tall the pen holder is
vaseHeight = 300;
//vaseHeight = 120;

// this sets how many cutouts are in the pen holder
charmCount = 35;

spursCharmStl = "../shapes/spurs/spurs-a.stl";
spursCharmXYScale = 0.2;  // spur scale
spursCharmDepthScale = 20.2;   // oshw depth scale

oshwCharmStl = "../shapes/oshw/oshw.stl";
oshwCharmXYScale = 0.7;
oshwCharmDepthScale = 40.2;

starCharmStl = "../shapes/star/star.stl";
starCharmXYScale = 0.7;
starCharmDepthScale = 40.2;

charmStls = [
                spursCharmStl,
                oshwCharmStl,
                starCharmStl
            ];

charmXYScales = [
                    spursCharmXYScale,
                    oshwCharmXYScale,
                    starCharmXYScale
                ];
                
charmDepthScales = [
                        spursCharmDepthScale,
                        oshwCharmDepthScale,
                        starCharmDepthScale
                   ];

uniqueCharmCount = len(charmStls);

charmIndex = -1;

randomSeed = 2789676;
// uncomment this next line to have a different pattern each time the model is rendered in OpenSCAD.	
//	randomSeed = rands(0,987654, 1)[0];

maxRandom = uniqueCharmCount - 1;
randomCharmIndcies = rands(0,maxRandom, charmCount, randomSeed);

difference()
{
	cup(vaseHeight);

    // the cutouts of lucky charms
    for( i = [0 : charmCount-1] )
    {
        single_rand = randomCharmIndcies[i];
		
        charmIndex = round(single_rand);
        
//echo(charmIndex);
        
        rotate([
                90, 
                0,
                i * 38
        ])        
        translate([15, 5 * i, 30])            // normally x,y,z - but here y moves the charms up and down
        scale([charmXYScales[charmIndex],
               charmXYScales[charmIndex], 
               charmDepthScales[charmIndex]
              ])
        import(charmStls[charmIndex]);
    }
}