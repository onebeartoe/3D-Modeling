
module dome(radius = 15, shellThickness = 2, domePercentage = 100)
{
    difference()
    {
        sphere(r = radius);

        innerRadius = (radius - shellThickness);
        sphere(r = innerRadius);

        zTranslate = -radius * domePercentage/100;
        translate([0, 0, zTranslate])
        cube(radius*2, center=true);
    }
}