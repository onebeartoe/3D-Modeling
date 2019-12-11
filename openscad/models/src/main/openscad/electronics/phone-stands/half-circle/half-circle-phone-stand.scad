
use <../../../basics/rounded-edges/doughnuts/doughnuts.scad>;

use <../../../basics/rounded-edges/rounded-pyramid/rounded-pyramid.scad>;

use <../../../shapes/geometry/arc/extruded/extruded-arc.scad>;

use <../../../external-resources/aquaman/aquaman-logo.scad>
use <../../../external-resources/cat/cat.scad>
use <../../../external-resources/che-thild/che-thild.scad>
use <../../../external-resources/music/notes/bass-clef/bass-clef.scad>
use <../../../external-resources/music/notes/treble-clef/treble-clef-scaled-down.scad>
use <../../../external-resources/plumber-brother/l/luigi-outline.scad>
use <../../../external-resources/plumber-brother/m/mario.scad>
use <../../../external-resources/rebel-alliance/rebel-alliance.scad>
use <../../../external-resources/thundercats/thundercats-logo.scad>
use <../../../external-resources/trooper/scrum-trooper.scad>
use <../../../shapes/crescent-moon/crescent-moon.scad>
use <../../../shapes/fan/iso-7000-fan.scad>
use <../../../shapes/fish/fish.scad>
use <../../../shapes/heart/heart.scad>
use <../../../shapes/light-bulb/light-bulb.scad>
use <../../../shapes/minecraft/creeper/creeper-face.scad>
use <../../../shapes/spurs/spurs-a.scad>
use <../../../shapes/weather/sun/sun.scad>

module halfCirclePhoneStand(base_xTranslate = -1.0,
                            base_yTranslate = -1.0,

                            bed_cutout_zLength = 4.2,
                            height = 19.125,
   
                            iconColor = "red", 
                            iconType = "None", 
                            iconXyScale = 1.0, 
                            iconHeight = 3.0, 
                            icon_xOffset = 5, 
                            icon_yOffset = 5,
                            icon_zOffset = 5,

                            minkowskiSphereRadius = 0.5,
                            arcRadius = 36,
                            arcRadiusExtension = 1.5,
                            
                            stand_top_xTranslate = 9.105,
                            stand_top_yTranslate = 9.85,
                            stand_connectorBar_xLength = 5)
{
    halfCirclePhoneStand_cradle(height = height,
    
                                bed_cutout_zLength = bed_cutout_zLength,

                                iconColor = iconColor, 
                                iconType = iconType, 
                                iconXyScale = iconXyScale, 
                                iconHeight = iconHeight, 
                                icon_xOffset = icon_xOffset, 
                                icon_yOffset = icon_yOffset,
                                icon_zOffset = icon_zOffset,

                                minkowskiSphereRadius = minkowskiSphereRadius,
                                radius = arcRadius,
                                radiusExtension = arcRadiusExtension);

    halfCirclePhoneStand_stand(base_xTranslate = base_xTranslate,
                               base_yTranslate = base_yTranslate,
                               bed_cutout_zLength = bed_cutout_zLength,
                               height = height,
                               minkowskiSphereRadius = minkowskiSphereRadius,
                               stand_connectorBar_xLength = stand_connectorBar_xLength,
                               stand_top_xTranslate = stand_top_xTranslate,
                               stand_top_yTranslate = stand_top_yTranslate);
}

// sub-modules and functions follow

function halfCirclePhoneStand_cradle_cutout_zTranslate(minkowskiSphereRadius, 
                                                        bedHeight,
                                                        zLength) = minkowskiSphereRadius + (bedHeight / 2.0) - (zLength / 2.0);

module halfCirclePhoneStand_cradle(height,

                                   bed_cutout_zLength,

                                   iconColor, iconType, iconXyScale, iconHeight, 
                                   icon_xOffset, icon_yOffset, icon_zOffset,
  
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
                                        bed_yTranslate = yTranslate,
                                        bed_cutout_zLength = bed_cutout_zLength);
    }

    halfCirclePhoneStand_cradle_icon(iconColor = iconColor, 
                                     iconType = iconType, 
                                     iconXyScale = iconXyScale, 
                                     iconHeight = iconHeight, 
                                     xOffset = icon_xOffset, 
                                     yOffset = icon_yOffset,
                                     zOffset = icon_zOffset);  

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
                                          bed_yTranslate,
                                          bed_cutout_zLength)
{
    zLength = bed_cutout_zLength;

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

module halfCirclePhoneStand_cradle_icon(iconColor, iconType, iconXyScale, iconHeight, xOffset, yOffset, zOffset)
{
//echo("xOffset", xOffset);

    color(iconColor)
    
    translate([xOffset, yOffset, zOffset])
    rotate([0, 90, 0])
    scale([iconXyScale, iconXyScale, iconHeight])
    if(iconType == "Aqua Dude")
    {
        aquamanThumbnail(height=2.19);
    }
    else if(iconType == "Bass Clef")
    {
    	bassClefThumbnail(height = 2.7);
    }
    else if(iconType == "Cat")
    {
        catThumbnail(height = 2, xyScale = 0.37);
    }
    else if(iconType == "Creeper")
    {
        creeperFaceThumbnail(height = 1.7);
    }
    else if(iconType == "Fan")
    {
        scale([1, 1, 2.1])
        fanThumbnail();
    }
    else if(iconType == "Fish")
    {
        scale([1, 1, 1.6])
        fishThumbnail();
    }
    else if(iconType == "Heart")
    {
        scale([1, 1, 1.9])
        heartThumbnail();
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
    else if(iconType == "The Kid")
    {
        theChildThumbnail(height = 1.6);
    }
    else if(iconType == "Trooper")
    {
        scrumTrooperThumbnail(height = 2);
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

module halfCirclePhoneStand_stand(base_xTranslate,
                                  base_yTranslate,
                                  bed_cutout_zLength,
                                  height,
                                  minkowskiSphereRadius,
                                  stand_connectorBar_xLength,
                                  stand_top_xTranslate,
                                  stand_top_yTranslate)
{
    halfCirclePhoneStand_stand_top(height = height,
                                   minkowskiSphereRadius = minkowskiSphereRadius,
                                   xTranslate = stand_top_xTranslate,
                                   yTranslate = stand_top_yTranslate);

    halfCirclePhoneStand_stand_connectorBar(bed_cutout_zLength = bed_cutout_zLength,
                                            bedHeight = height,
                                            minkowskiSphereRadius = minkowskiSphereRadius,
                                            xLength = stand_connectorBar_xLength);

    halfCirclePhoneStand_stand_base(height = height,
                                    minkowskiSphereRadius = minkowskiSphereRadius,
                                    xTranslate = base_xTranslate,
                                    yTranslate = base_yTranslate);
}
   
module halfCirclePhoneStand_stand_base(height,
                                       minkowskiSphereRadius,
                                       xTranslate,
                                       yTranslate)
{
    color("green")
    translate([xTranslate, yTranslate, minkowskiSphereRadius])
    roundDoughnut(height = height,
                innerRadius = 4.9,      // 4.9
                outerRadius = 5.59,     // 5.59
                minkowskiSphereRadius = minkowskiSphereRadius);
}

module halfCirclePhoneStand_stand_connectorBar(bed_cutout_zLength, minkowskiSphereRadius, bedHeight, xLength)
{
    yLength = 3;   
    zLength = bed_cutout_zLength + minkowskiSphereRadius;
   
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
                                      minkowskiSphereRadius,
                                      xTranslate,
                                      yTranslate)
{
    color("green")
    translate([xTranslate, yTranslate, minkowskiSphereRadius])
    roundDoughnut(height = height,
                innerRadius = 1.9,
                outerRadius = 2.6,
                minkowskiSphereRadius = minkowskiSphereRadius);
}
