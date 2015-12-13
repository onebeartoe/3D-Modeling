
// Ths OpenSCAD script is a direvative of:
// Customizable Gimbal v1.0
// by TheNewHobbyist 2014 (http://thenewhobbyist.com)
// http://www.thingiverse.com/thing:340948
// https://github.com/thenewhobbyist/OpenSCAD/tree/master/Customizable%20Gimble
//
// "Customizable Gimbal" as well as this script are licensed under a 
// Creative Commons Attribution-NonCommercial 3.0 Unported License.
//
// "Customizable Gimbal" Description: 
// This model was insirped by DesignMakeTeach's print in place gimbal designs 
// on Thingiverse. Below I have linked an example. I personalized one of these
// for myself and thought I'd make it a full on Customizer model. To do this
// I recreated something similar to DesignMakeTeach's design in OpenSCAD and 
// used the Stencil-o-Matic from Benjamin to add in some easy customization.
//
// TheNewHobbyist's Inspiration and attribution from:
//
// Printrbot Gimbal by DesignMakeTeach 
// http://www.thingiverse.com/thing:317778
// Licensed under the Creative Commons - Attribution - Share Alike license.
//
// Stencil-o-Matic by Benjamin
// http://www.thingiverse.com/thing:55821
// Licensed under the Creative Commons - Attribution - Non-Commercial license.

// Coin and pendant features were added by Roberto Marquez - http://electronics.onebeartoe.org/

use <spur/spurs-rotated/spurs-rotated.scad>;

/* [Dimensions] */

// Paste your Sencil-o-Matic code here
input ="default_TNH";

// Move image left/right
Move_X = 0; // [-50:50]

// Move image up/down
Move_Y = 0; // [-50:50]

// Resize your image
image_size = 26.5; // [1:50]

/* [Hidden] */

  ///////////////////////////
 // Stencil-o-Matic Stuff //
///////////////////////////

stencil_thickness = 5;
offX = 0;
offY = 0;
margin = 0;
dispo_width = image_size;

points_array = (input=="default_TNH"? [[133,286],[[234.27,6.02],[231.55,7.45],[227.5,10.88],[222.85,15.67],[218.69,20.35],[214.95,25.17],[211.32,30.24],[208.44,34.98],[206.52,39],[205.31,48.23],[204.14,65.5],[202.43,96.43],[199.95,138.5],[197.65,174.91],[196.37,192.25],[195.44,195.38],[192.95,196],[190.58,196.5],[189.09,197.84],[188.55,199.75],[188.65,201.77],[188.28,204.15],[185.74,207.18],[181.17,210.7],[175.06,214.5],[168.61,218.79],[163.29,223.5],[159.05,228.64],[155.24,233.98],[152.19,239.17],[149.77,243.98],[148.11,250.02],[146.97,258.66],[145.84,267.33],[144.06,272.66],[141.97,276.16],[139.87,279.16],[138.4,281.78],[138.36,284.3],[139.83,286.58],[143.12,288.43],[150.09,289.9],[162.38,291.02],[181.28,291.67],[205.5,291.95],[229.79,291.67],[248.86,291],[261.56,289.87],[267.86,288.28],[270.76,286.27],[271.82,283.7],[271.26,280.36],[268.97,275.96],[266.18,270.14],[264.49,261.76],[263.22,253.76],[262.03,247.53],[260.34,242.46],[257.87,237.27],[254.58,232.07],[250.91,227.01],[246.01,222],[239.74,216.91],[233.89,213.03],[230,210.88],[227.72,209.34],[225.75,206.9],[224.51,204.05],[224,201.5],[223.82,199.39],[223.39,197.58],[222.07,196.41],[219.45,196],[216.94,195.74],[215.57,195.11],[215.61,179.54],[216.5,143.36],[217.84,100.02],[218.98,67.24],[219.99,41.97],[223.5,34.86],[227.01,28.44],[230.51,22.99],[232.97,19.44],[234,17.58],[234.64,16.25],[236.17,13.98],[237.73,11.12],[237.19,8.52],[235.86,6.75],[234.27,6.02]],[[212.84,76.5],[212.5,59.5],[211.74,69.5],[210.48,90.08],[208.53,125.5],[206.63,159.58],[205.5,176.93],[204.81,181.12],[203.95,183.56],[203.18,185.98],[202.73,190.13],[202.5,195.5],[206.22,195.81],[209.36,195.65],[210.42,193.81],[211.09,177.78],[212.04,142.5],[212.75,102.9],[212.84,76.5]],[[206,209],[195.82,209.28],[191.5,210],[194.92,210.74],[206,211],[217.08,210.74],[220.5,210],[216.18,209.28],[206,209]],[[205.86,215.72],[183.79,215.5],[178.37,218.41],[172.58,222.55],[166.23,228.5],[160.29,235.76],[156.27,243.19],[153.68,250.66],[151.96,258.09],[150.89,264.79],[149.83,270.5],[148.37,275.16],[146.32,279.34],[144.69,282.17],[144.25,283.58],[147.3,284.15],[154.07,284.97],[173.01,285.68],[205.29,285.98],[237.8,285.68],[256.79,284.92],[263.77,284.03],[266.92,283.42],[266.23,281.75],[264,278.35],[260.66,273.7],[259.87,264.1],[259.05,256.44],[258.15,251.5],[256.85,248.06],[255.05,244],[252.96,239.81],[250.98,236.07],[248.08,232.07],[243.79,227.28],[238.5,222.61],[233.21,218.93],[227.93,215.94],[205.86,215.72]],[[156.85,278.42],[154.78,278.35],[153.53,278.95],[153.45,279.83],[154.19,280.46],[157.32,281.08],[163,281.96],[173.19,282.99],[187.17,283.97],[203.88,284.41],[220.67,283.98],[234.91,283.01],[245.5,281.96],[251.42,280.91],[254.43,279.94],[254.97,279.17],[254.93,278.6],[251.4,278.77],[243.5,279.76],[228.64,280.99],[205,281.42],[182.42,281.13],[168.5,280.22],[161.36,279.17],[156.85,278.42]]]: input);
input_width = points_array[0][0];
input_height= points_array[0][1];
sTrace = dispo_width/input_width;
stencil_height = input_height*sTrace + 2*margin;

$fn=100;
// preview[view:south, tilt:top]

ornament();

module ornament()
{
    {
        union()
        {
            ring1();
            ring2();
            ring3();
            difference()
            {
                color("blue") 
                pattern();
                
                cutout(center=true);
            }
        }
    }    
}

module pattern()
{
    union()
    {
    	scale([sTrace, -sTrace, 1]) 
    	{
    		union() 
    		{
    		    coin(height=5);
			}
		}
	}
}

//Clip oversized images here
module cutout()
{ 
	difference()
	{
		cylinder(r=200, h=10, center=true);
		cylinder(r=11, h=11, center=true);
	}
}

module ring1()
{
	difference()
	{
	cylinder(r=19.35, h=5, center=true);
	cylinder(r=17.35, h=56, center=true);
	translate([17.45,0,0]) rotate([0,90,0]) cylinder(r1=1.7, r2=0, h=2.1, center=true);
	translate([-17.45,0,0]) rotate([0,270,0]) cylinder(r1=1.7, r2=0, h=2.1, center=true);
	}
}

module ring2()
{
	translate([16.95,0,0]) rotate([0,90,0]) cylinder(r1=1.7, r2=0, h=2.1, center=true);
	translate([-16.95,0,0]) rotate([0,270,0]) cylinder(r1=1.7, r2=0, h=2.1, center=true);
	difference()
	{
		cylinder(r=15.95, h=5, center=true);
		cylinder(r=13.95, h=56, center=true);
		translate([0,-14.2,0]) rotate([90,0,0]) cylinder(r1=1.7, r2=0, h=2.1, center=true);
		translate([0,14.2,0]) rotate([270,0,0]) cylinder(r1=1.7, r2=0, h=2.1, center=true);
	}
}

module ring3()
{
	translate([0,13.75,0]) rotate([270,0,0]) cylinder(r1=1.7, r2=0, h=2.1, center=true);
	translate([0,-13.75,0]) rotate([90,0,0]) cylinder(r1=1.7, r2=0, h=2.1, center=true);
	difference()
	{
		cylinder(r=12.75, h=5, center=true);
		cylinder(r=10.75, h=56, center=true);
	}
}