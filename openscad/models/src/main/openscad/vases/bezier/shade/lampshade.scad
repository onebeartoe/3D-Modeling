
module bezierLampshade(beadCount = 34,
                        beadRadius = 7,
                        beadResolution = 20, 
                        ringCount = 10,
                        ringRadius = 60)
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
    legCount = 3;

    difference()
    {
        spiderSolids(legCount, ringRadius);

        spiderCutouts();
    }
}

module spiderSolids(legCount,
                    ringRadius)
{
    xLength = 15;

    yLength = ringRadius;

    zLength = 10;

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

    innerRadius = 40; // the E27 fitting has a 40mm inner radius

    mountingRingRadius = innerRadius + xLength;

    difference()
    {
        cylinder(h = zLength, r = mountingRingRadius);

        translate([0, 0, -0.001])
        cylinder(h = zLength + 0.002, r = innerRadius);        
    }
}

module spiderCutouts()
{

}


