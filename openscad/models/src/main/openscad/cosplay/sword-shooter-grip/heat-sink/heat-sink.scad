
module heatSink(finHeight = 5,
                height = 60,
                innerRadius = 30,
                outerRadiusAdustment = 5)
{
    union()
    {
        // core
        color("black")
        cylinder(h = height,
                 r = innerRadius);

        // fins
        outerRadius = innerRadius + outerRadiusAdustment;

        for(i = [0 : 6]) 
        {
            zTranslate = i  * finHeight * 2;

            color("silver")
            translate([0,0,zTranslate])
            cylinder(h = finHeight,
                     r = outerRadius);
        }
    }
}