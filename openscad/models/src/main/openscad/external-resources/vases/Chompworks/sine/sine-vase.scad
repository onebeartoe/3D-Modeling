
// originially from:
//    Sine Cube Vase 1 by @Chompworks
//    Original at: https://www.thingiverse.com/thing:2666281
//    Released under the Creative Commons CC - BY 3.0 licence
//    Details here: https://creativecommons.org/licenses/by/3.0/
//
// customizer modifications by Roberto Marquez include cylinder and sphere options
//    https://www.thingiverse.com/onebeartoe/designs

use <../../../../shapes/heart/heart.scad>

module sineVase(internalCutout_bottomRadius,
                internalCutout_TopRadiusOffset = 22,
                vaseMode = false,
                vaseMode_topChopOff_zOffset,
                vaseType



,
heart_xRotate,
heart_yRotate,
heart_zRotate

            )
{
    step = 4; // number of degrees to step for each cuboid element

//    maxlayers = 1;
    maxlayers=100; // max number of layers. More layers slows down compilation on [F6], but makes the vase taller

    basewidth=50; // basic length of a cuboid

    internalCutout_TopRadius = internalCutout_bottomRadius + internalCutout_TopRadiusOffset;

    difference() // Take away the two parts at the bottom
    {
        union() // this stitches all the cuboids together
        {
            translate([0,0,-80])
            for (layers=[1:maxlayers]) // make each slice
            {
                for (angle=[1:step:360])
                {
                    translate([0,0,layers*2]) // move the cuboid up to where it needs to be!
                    rotate([0,0,angle]) // rotate the cuboid
                    rotate([45,-45,0]) // rotate the cuboid for the best effect
                    translate([0,-1,0]) // move the cuboid. This minus 1 offset just worked well!


                    if(vaseType == "cylinder")
                    {
                        cylinderHeight = basewidth + (layers/maxlayers*30) + 10*cos(layers*15) * sin(angle*8);

                        cylinder(r=2, h=cylinderHeight, $fn=20);
                    }
                    else if( vaseType == "heart")
                    {
                        heartHeight = basewidth + (layers/maxlayers*30) + 10*cos(layers*15) * sin(angle*8);

                        color("red")
                        translate([heartHeight, 0, 0])
                        rotate([heart_xRotate, heart_yRotate, heart_zRotate])
                        scale([0.25, 0.25, 0.25])
                        heartThumbnail(height =10);
                    }
                    else if( vaseType == "sphere")
                    {
                        sphereHeight = basewidth + (layers/maxlayers*30) + 10*cos(layers*15) * sin(angle*8);

                        color("blue")
                        translate([sphereHeight, 0, 0])
                        sphere(r = 5, $fn = 50);
                    }
                    else
                    {
                        // cube is the default

                        cube_xLength = basewidth + (layers/maxlayers*30) + 10*cos(layers*15) * sin(angle*8);

        				cube([cube_xLength, 4, 4]);

                            // lets explain this!
                            // make a 4x4 square
                            // then extrude it by:
                                // basewidth - a constant. this is the minimum length of any cuboid
                                // PLUS
                                // (layers/maxlayers*30) - this makes the vase taper outward as it gets taller. A sine function on this could make it act more like a pot/urn [Thin, Fat, Thin]
                                // PLUS
                                // 10*cos(layers*15)*sin(angle*8) - this is a nasty bit of trig at first!
                                // the sine function controls the bumps. Multiplying the angle by 8 means that rather than 1 bump, there are 8 for any given layer
                                // the cosine function (layers*15) makes the bumps also occur in the Z axis as they go up. If you removed this, the vase becomes very straight
                    }
                }
            }

            if(vaseType == "sphere"
                || vaseType == "heart")
            {
                // add a bottom disk

                baseRadius = basewidth - 6;

                color("green")
                cylinder(r = baseRadius, h = 5, $fn = 20);
            }
        }

        //this removes the cone base and leaves a flat base for the vase
        translate([-500,-500,-100])
        cube([1000,1000,100]);

        if(vaseMode)
        {
            // chop off the top of the vaseMode

            topChopOffRadis = internalCutout_TopRadius + 20;

            topChopOff_zTranslate = maxlayers + vaseMode_topChopOff_zOffset;

            color("pink")
            translate([0, 0, topChopOff_zTranslate])
            cylinder(r = topChopOffRadis, h = 70);
        }
        else
        {
            // this adds an internal hollow, 5mm up from the base

            translate([0,0,5])
            cylinder(r1 = internalCutout_bottomRadius, r2 = internalCutout_TopRadius, h = maxlayers * 2, $fn = 360/step);
        }
    }
}
