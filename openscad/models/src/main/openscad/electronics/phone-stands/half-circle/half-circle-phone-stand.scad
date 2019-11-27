
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>;

use <../../../basics/rounded-edges/rounded-pyramid/rounded-pyramid.scad>;

use <../../../shapes/geometry/arc/extruded/extruded-arc.scad>;

module halfCirclePhoneStand(height = 19.125,

                            iconColor = "red", 
                            iconType = "None", 
                            iconXyScale = 1.0, 
                            iconHeight = 3.0, 
                            icon_xOffset = 5, 
                            icon_yOffset = 5,

                            minkowskiSphereRadius = 0.5,
                            arcRadius = 36,
                            arcRadiusExtension = 1.5)
{
    halfCirclePhoneStand_cradle(height = height,

                                iconColor = iconColor, 
                                iconType = iconType, 
                                iconXyScale = iconXyScale, 
                                iconHeight = iconHeight, 
                                icon_xOffset = icon_xOffset, 
                                icon_yOffset = icon_yOffset,

                                minkowskiSphereRadius = minkowskiSphereRadius,
                                radius = arcRadius,
                                radiusExtension = arcRadiusExtension);

    halfCirclePhoneStand_stand(height = height,
                               minkowskiSphereRadius = minkowskiSphereRadius);
}

// sub-modules and functions follow

function halfCirclePhoneStand_cradle_cutout_zLength() = 4.2;

function halfCirclePhoneStand_cradle_cutout_zTranslate(minkowskiSphereRadius, 
                                                        bedHeight,
                                                        zLength) = minkowskiSphereRadius + (bedHeight / 2.0) - (zLength / 2.0);

module halfCirclePhoneStand_cradle(height,

                                   iconColor, iconType, iconXyScale, iconHeight, icon_xOffset, icon_yOffset,

                                   minkowskiSphereRadius,
                                   radius,
                                   radiusExtension)
{
    xTranslate = 30;
    yTranslate = 32.7;

    difference()
    {
        halfCirclePhoneStand_cradle_bed(height = height,
                                           minkowskiSphereRadius = minkowskiSphereRadius,
                                           radius = radius,
                                           radiusExtension = radiusExtension,
                                           xTranslate = xTranslate,
                                           yTranslate = yTranslate);

        halfCirclePhoneStand_cradle_cutout(bedHeight = height,
                                        minkowskiSphereRadius = minkowskiSphereRadius,
                                        radius = radius,
                                        radiusExtension = radiusExtension,
                                        bed_xTranslate = xTranslate,
                                        bed_yTranslate = yTranslate);
    }

    halfCirclePhoneStand_cradle_icon(iconColor = iconColor, 
                                     iconType = iconType, 
                                     iconXyScale = iconXyScale, 
                                     iconHeight = iconHeight, 
                                     xOffset = icon_xOffset, 
                                     yOffset = icon_yOffset);  

    halfCirclePhoneStand_cradle_ends(height = height,
                                     minkowskiSphereRadius = minkowskiSphereRadius);
}

module halfCirclePhoneStand_cradle_bed(height,
                                       minkowskiSphereRadius,
                                       radius,
                                       radiusExtension,
                                       xTranslate,
                                       yTranslate)
{
    zTranslate = minkowskiSphereRadius;
    color("magenta")
    translate([xTranslate, yTranslate, zTranslate])
    rotate([0, 0, 213])     
    roundedRectangularArc(angle = 150,
                          height = height,
                          minkowskiRadius = minkowskiSphereRadius,
                          radius = radius,
                          radiusExtension = radiusExtension);
}

module halfCirclePhoneStand_cradle_cutout(bedHeight,
                                          minkowskiSphereRadius,
                                          radius,
                                          radiusExtension,
                                          bed_xTranslate,
                                          bed_yTranslate)
{
    zLength = halfCirclePhoneStand_cradle_cutout_zLength();

    cutoutRadiusExtension = radiusExtension + 3;

    xTranslate = bed_xTranslate + 0.2;
    yTranslate = bed_yTranslate + 0.2;
    zTranslate = halfCirclePhoneStand_cradle_cutout_zTranslate(minkowskiSphereRadius = minkowskiSphereRadius, 
                                                                bedHeight = bedHeight,
                                                                zLength = zLength);

    color("DarkTurquoise")
    translate([xTranslate, yTranslate, zTranslate])
    rotate([0, 0, 227])     
    roundedRectangularArc(angle = 37,
                          height = zLength,
                          minkowskiRadius = minkowskiSphereRadius,
                          radius = radius,
                          radiusExtension = cutoutRadiusExtension);
}

module halfCirclePhoneStand_cradle_ends(height,
                                        minkowskiSphereRadius)
{
    halfCirclePhoneStand_cradle_ends_top(height = height,
                                            minkowskiSphereRadius = minkowskiSphereRadius);

    halfCirclePhoneStand_cradle_ends_bottom(height = height,
                                            minkowskiSphereRadius = minkowskiSphereRadius);
}

module halfCirclePhoneStand_cradle_ends_bottom(height,
                                               minkowskiSphereRadius)
{
    xTranslate = 2.8;
    yTranslate = 56.35;
    zTranslate = minkowskiSphereRadius;

    // bottom end
    color("PaleTurquoise")
    translate([xTranslate, yTranslate, zTranslate])
    halfCirclePhoneStand_cradle_ends_cylinder(height = height,
                                              minkowskiSphereRadius = minkowskiSphereRadius);
}

module halfCirclePhoneStand_cradle_ends_top(height,
                                        minkowskiSphereRadius)
{
    xTranslate = 40.3;
    yTranslate = -2.5;
    zTranslate = minkowskiSphereRadius;

    // bottom end
    color("PaleTurquoise")
    translate([xTranslate, yTranslate, zTranslate])
    halfCirclePhoneStand_cradle_ends_cylinder(height = height,
                                              minkowskiSphereRadius = minkowskiSphereRadius);
}

module halfCirclePhoneStand_cradle_ends_cylinder(height,
                                        minkowskiSphereRadius)
{
    roundedPyramid(h = height,
                   cornerRadius = minkowskiSphereRadius,
                   cylinderFn = 20,
                   r1 = 2.57,
                   r2 = 2.57,
                   sides = 30);
}

module halfCirclePhoneStand_cradle_icon(iconColor, iconType, iconXyScale, iconHeight, xOffset, yOffset)
{
    color(iconColor)
    translate([xOffset, yOffset, 0])
    scale([iconXyScale, iconXyScale, iconHeight])
    if(iconType == "Aqua Dude")
    {
        aquamanThumbnail(height=1.6);
    }
    else if(iconType == "Bass Clef")
    {
    	baseclef15scale(1.8);
    }
    else if(iconType == "Cat")
    {
        cat(1.8);
    }
    else if(iconType == "Creeper")
    {
        creeperFaceThumbnail(height = 1.7);
    }
    else if(iconType == "Fan")
    {
        scale([1, 1, 1.6])
        fanThumbnail();
    }
    else if(iconType == "Fish")
    {
        scale([1, 1, 1.6])
        fishThumbnail();
    }
    else if(iconType == "Light Bulb")
    {
        lightBulbThumbnail();
    }
    else if(iconType == "Mario")
    {
        marioThumbnail();
    }
    else if(iconType == "Luigi")
    {
        luigiThumbnail();
    }
    else if(iconType == "Moon")
    {
        crescentMoonThumbnail();
    }
    else if(iconType == "Rebel")
    {
        rebelAllianceThumbnail(height = 1.7);
    }
    else if(iconType == "Spur")
    {
        spurThumbnail();
    }
    else if(iconType == "Sun")
    {
        sunThumbnail(height = 1.6);
    }
    else if(iconType == "Trooper")
    {
        scrumtrooper(2);
    }
    else if(iconType == "Thundercat")
    {
        thundercatsLogoThumbnail(height = 1.7);
    }
    else if(iconType == "Treble Clef")
    {
        trebleClefScaledDownThumbnail(h=2);
    }
    else
    {
        echo("drawing no icon");
    }
}

module halfCirclePhoneStand_stand(height,
                                  minkowskiSphereRadius)
{
    halfCirclePhoneStand_stand_top(height = height,
                                   minkowskiSphereRadius = minkowskiSphereRadius);

    halfCirclePhoneStand_stand_connectorBar(bedHeight = height,
                                            minkowskiSphereRadius = minkowskiSphereRadius);

    halfCirclePhoneStand_stand_base(height = height,
                                    minkowskiSphereRadius = minkowskiSphereRadius);
}

module halfCirclePhoneStand_stand_base(height,
                                       minkowskiSphereRadius)
{
    color("green")
    translate([0, 0, minkowskiSphereRadius])
    roundDoughnut(height = height,
                innerRadius = 4.9,      // 4.9
                outerRadius = 5.59,     // 5.59
                minkowskiSphereRadius = minkowskiSphereRadius);
}

module halfCirclePhoneStand_stand_connectorBar(minkowskiSphereRadius, bedHeight)
{
    xLength = 5;
    yLength = 3;
    zLength = halfCirclePhoneStand_cradle_cutout_zLength() + minkowskiSphereRadius;

    xTranslate = 5;
    yTranslate = 5;
    zTranslate = halfCirclePhoneStand_cradle_cutout_zTranslate(minkowskiSphereRadius = minkowskiSphereRadius, 
                                                                bedHeight = bedHeight,
                                                                zLength = zLength)
                    + (zLength / 2.0);

    color("blue")
    translate([xTranslate, yTranslate, zTranslate])
    rotate([0, 0, 45])
    cube([xLength, yLength, zLength], center = true);
}

module halfCirclePhoneStand_stand_top(height,
                                      minkowskiSphereRadius)
{
    xTranslate = 8.105;  // 8.05     // 8.1
    yTranslate = 8.85;  // 8.85     // 8.9

    color("green")
    translate([xTranslate, yTranslate, minkowskiSphereRadius])
    roundDoughnut(height = height,
                innerRadius = 1.9,  // 2.0
                outerRadius = 2.6,  // 2.6
                minkowskiSphereRadius = minkowskiSphereRadius);
}
