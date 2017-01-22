
/**
 * This script renders onebeartoe Fidget Spinners!
 * 
 * Author: Roberto Marquez
 * 
 * https://plus.google.com/u/0/104101484714566033177
 * https://twitter.com/onebeartoe
 * https://www.youtube.com/user/onebeartoe/videos
 * 
 *  Originally from: http://www.thingiverse.com/thing:1937473 
 *  Original Author: Geoff Buttsworth
 *  Original Filename: moneySpinner02
 *  Borrowed from Version: 0.5
 *  Twitter: @gbutts9
 * 
 *  This version is designed to work with the Thingiverse Customizer.
 *  Ref: http://customizer.makerbot.com/docs
 */

use <../../external-resources/adafruit/fidget-spinner/ada-spinner-flat.scad>
use <../../external-resources/aquaman/aquaman-logo.scad>
use <../../external-resources/batman/batman.scad>        
use <../../external-resources/knurled-surface/aubenc/knurledFinishLib_v2.scad>
use <../../external-resources/oshw/oshw-logo-800-px.scad>;
use <../../external-resources/rebel-alliance/rebel-alliance.scad>
use <../../external-resources/time-bandits/fidget-outline.scad>
use <../../shapes/clover/clover.scad>
use <../../shapes/heart/heart.scad>
use <../../shapes/pacman/pacman.scad>        
use <../../shapes/spurs/spurs-a.scad>
use <../../shapes/star/star.scad>;

/* [Spinner_Parameters] */
//Which coin do you want to use?
coin_list = 8; //[1:AU $2,2:AU 5c,3:US 10c,4:UK £1,5:UK 5p,6:EU €1,7:QA 0.5QAR,8:US 5c]
coin = coin_list;

cutoutName = "Fidget (Time Bandits)";    // [Adafruit, Aqua Dude, Bat, Clover, Fidget (Time Bandits), Heart, Pacman, OSHW, Rebel Alliance, Spur, Star]

//How many spokes should the spinner have?
Number_of_Spokes = 2; //[2,3,4,5,6,7]
spokeNumber = Number_of_Spokes;

//Flush for easier printing 
Flush_or_Raised_Hub = 1; //[0:Hub,1:Flush]
flush = Flush_or_Raised_Hub; //Flush is easier to print, the hub is height of bearing and may print with support

//Allocate coin data

// !!!!!to make the spoke count this is needed, so far.  or maybe not!!!!
//coinName = coin == 1 ? "AU $2" :
//        (coin == 2 ? "AU 5c" :
//        (coin == 3 ? "US 10c" :
//        (coin == 4 ? "UK £1" :
//        (coin == 5 ? "UK 5p" :
//        (coin == 6 ? "EU €1" :
//        (coin == 7 ? "QA 0.5QAR" : "US 5c")
//        )
//        )
//        )
//        )
//        );

coin_d = coin == 1 ? 20.5 :
            (coin == 2 ? 19.4 :
                (coin == 3 ? 17.9 :
                    (coin == 4 ? 22.5 :
                        (coin == 5 ? 18.0 :
                            (coin == 6 ? 23.3 :
                                (coin == 7 ? 25.0 : 21.3)
                                                            )
                                                            )
                                                            )
                                                            )
                                                            );

coin_z = coin == 1 ? 2.8 :
        (coin == 2 ? 1.3 :
        (coin == 3 ? 1.35 :
        (coin == 4 ? 3.15 :
        (coin == 5 ? 1.8 :
        (coin == 6 ? 2.35 :
        (coin == 7 ? 1.78 : 1.95)
        )
        )
        )
        )
        );

stack = coin == 2 ? 3 :
        (coin == 3 ? 3 :
        (coin == 5 ? 3 :
        (coin == 7 ? 3 :
        (coin == 8 ? 4 : 2)
        )
        )
        );

//Default values
$fa = 0.8;
$fs = 0.8;

//Variables:

rim = 5;
holder_d = coin_d + rim;
holder_z = coin_z*stack;

brg_d = 22.0;
brg_z = 7.0;

spoke_x = coin_d / 2;
spoke_y = coin_d / 3;
spoke_z = holder_z;

//If flush: hub will be height of coin stack otherwise height of bearing
hub_z = flush == 1 ? coin_z*stack : brg_z;

//SpinnerModules

module cutout()
{
    if(cutoutName == "Adafruit")
    {
        scale([0.3, 0.3, 5])
        AdaSpinnerFlat_001();
    }
    if(cutoutName == "Aqua Dude")
    {
        aquamanThumbnail(height=10);
    }
    else if(cutoutName == "Bat")
    {
        translate([0, 0, 4])
        scale([1, 1, 4])
        batmanLogoThumbnail();
    }
    else if(cutoutName == "Clover")
    {
        translate([0, 0, -1])
        cloverThumbnail(height=10);
    }
    else if(cutoutName == "Fidget (Time Bandits)")
    {
        fidgetOutlineThumbnail(height = 10);
    }
    else if(cutoutName == "Heart")
    {
        heartThumbnail(height=10);
    }
    else if(cutoutName == "Rebel Alliance")
    {
        rebelAllianceThumbnail(height=10);
    }
    else if(cutoutName == "OSHW")
    {
        translate(0,0,10)
        scale([1, 1, 17])
        oshwLogoThumbnail();
    }
    else if(cutoutName == "Pacman")
    {
        translate([0, 0, 8])
        pacmanThumbnail(height = 15);
    }
    else if(cutoutName == "Spur")
    {
        scale([0.17, 0.17, 1])
        spur(height = 10);
    }
    else if(cutoutName == "Star")
    {
    	starThumbnail(height = 10);
    }
}

module dollarHolder() 
{
    translate([0, coin_d / 2 + spoke_y, 0])
    difference() 
    {
        // TODO: this next item looks like where the knurl can be swapped out for
        //       a regular cylinder or rounded cylinder.
        translate([0, 0, -coin_z * stack / 2])
        knurl(k_cyl_hg = holder_z, k_cyl_od = holder_d);

        xyScale = 0.75;
        translate([0, 0, -5])
        scale([xyScale, xyScale, 1])
        cutout();
    }
}

module hub() {
    cylinder(h = hub_z, d = brg_d + rim, center = true);
}

module spoke() {
    translate([0, spoke_y / 2, 0])
    cube([spoke_x, spoke_y, spoke_z], center = true);
}

module brgVoid() {
    cylinder(h = brg_z + 2, d = brg_d, center = true);
}

module holderSpoke() {

    translate([0, brg_d / 2, 0])
            union() {
        dollarHolder();
        spoke();
    }
}

//Rotate
rA = 360 / spokeNumber; //rotational angle
fA = round(360 - rA); //final angle

module spinner() {
    for (i = [0 : rA : fA]) {
        rotate([0, 0, i])
        holderSpoke();
    }
}

//Finalize

module plus() 
{
    hub();
    spinner();
}

module minus() 
{
    brgVoid();
}

//Render

difference() 
{
    plus();
    minus();
}