
module cornerCutoutShelfSupport(side = 60,
                               height = 40,
                               sideCutout = 15,
                               frontCutout = 21)
{
    difference()
    {
        color("brown")
        cube(size = [side, side, height]);

        cutout(sideCutout = sideCutout,
               frontCutout = frontCutout,
               height = height);
    }
}

module cutout(sideCutout ,
              frontCutout ,
              height )
{
    translate([-0.01, -0.01, -0.01])
    cube(size = [sideCutout, frontCutout, height + 0.02]);
}
