
module bezierLampshade(beadCount = 90,
                        beadRadius = 7,
                        beadResolution = 20, 
                        ringCount = 20,
                        ringRadius = 160)
{
    echo("bezierLapshade() begin");

    $fn = beadResolution;

    union()
    {
        shade(beadCount,
                beadRadius,
                beadResolution, 
                ringCount,
                ringRadius);

        spider(ringRadius);
    }

    echo("bezierLapshade() end");
}

module shade(beadCount,
                beadRadius,
                beadResolution, 
                ringCount,
                ringRadius)
{
    difference()
    {
        shadeSolids(beadCount,
                    beadRadius,
                    beadResolution, 
                    ringCount,
                    ringRadius);

        shadeCutouts(ringRadius);
    }
}

module shadeSolids(beadCount,
                    beadRadius,
                    beadResolution, 
                    ringCount,
                    ringRadius)
{
    for(z = [0 : ringCount])
    {
        for(s = [0 : beadCount])
        {
            angle = s * (360 / beadCount);

            zRotate = (z % 2 == 0) ? angle : angle + (angle * 0.3);

            zTranslate = beadRadius * 1.4 * z;

            rotate([0, 0, zRotate])
            translate([ringRadius,0,zTranslate])
            sphere(r=beadRadius);
        }
    }    
}

module shadeCutouts(ringRadius)
{
    z = 20;

    zTranslate = -z + (z / 2.0);

    side = ringRadius * 4;

    demensions = [side, side, z];
    translate([0,0,zTranslate])
    cube(size = demensions, 
         center = true);
}

module spider(ringRadius)
{
    innerRadius = 40; // the E27 fitting has a 40mm inner radius    

    legCount = 3;

    xLength = 15;

    zLength = 10;

    difference()
    {
        spiderSolids(innerRadius, legCount, ringRadius, xLength, zLength);

        spiderCutouts(innerRadius, zLength);
    }
}

module spiderSolids(innerRadius,
                    legCount,
                    ringRadius,
                    xLength,
                    zLength)
{
    yLength = ringRadius;

    for(s = [0 : legCount])
    {
        xTranslate = -xLength / 2.0;

        zRotate = s * (360 / legCount);

        zTranslate = 0;

        demensions = [xLength, yLength, zLength];

        rotate([0, 0, zRotate])
        translate([xTranslate,0,zTranslate])
        cube(size = demensions);
    }    



    mountingRingRadius = innerRadius + xLength;

    difference()
    {
        cylinder(h = zLength, r = mountingRingRadius);

        translate([0, 0, -0.001])
        cylinder(h = zLength + 0.002, r = innerRadius);        
    }
}

module spiderCutouts(innerRadius, zLength)
{
    height = zLength + 0.02;

    zTranslate = -0.001;

    $fn = 50;

    translate([0, 0, zTranslate])
    cylinder(h = height, r = innerRadius);
}


