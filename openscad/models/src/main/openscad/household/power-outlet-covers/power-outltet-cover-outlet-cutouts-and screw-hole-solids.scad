

// The dimentions are from the model made at TheNewHobbyist at
//      https://www.printables.com/model/72079-wally-wall-plate-customizer


//TODO: Comment to TheNewHobbyist about the 'go away Customizer' comment

1st_plate = "keystone1";

1st_plate_bottom_hole = "outlet";


l_offset = [34.925,39.6875,44.45];
r_offset = [34.925,39.6875,44.45];



// Bigger hole in your wall? Try this
plate_size = 0; // [0:Standard, 1:Junior-Jumbo, 2:Jumbo]

height_sizes = [114.3,123.825,133.35];

height = 114.3; //plate height (static)


plate1();//1st_plate = 1st_plate,            1st_plate_bottom_hole = 1st_plate_bottom_hole);

// plate1_solid(1st_plate = 1st_plate,
//              1st_plate_bottom_hole = 1st_plate_bottom_hole);

module plate1_solid()
{
    if (1st_plate == "keystone1" && 1st_plate_bottom_hole == "none") {
        translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5,-3.9]) hole("keystone_solid");
        }
    else if (1st_plate == "keystone1" && 1st_plate_bottom_hole != "outlet" && 1st_plate_bottom_hole != "toggle" && 1st_plate_bottom_hole != "rocker") 
    {
        translate([height_sizes[plate_size]/2,l_offset[plate_size] - 11.5,-3.9]) hole("keystone_solid");
    }
    if (1st_plate_bottom_hole == "keystone1" && 1st_plate == "none") {
        translate([height_sizes[plate_size]/2 + 14.3,l_offset[plate_size] - 11.5,-3.9]) hole("keystone_solid");
        }
    else if (1st_plate_bottom_hole == "keystone1" && 1st_plate != "outlet" && 1st_plate != "toggle" && 1st_plate != "rocker") {
        translate([height_sizes[plate_size]/2 + 28.5,l_offset[plate_size] - 11.5,-3.9]) hole("keystone_solid");
	}
}



module outletCutout()
{
    hole_type = "outlet";


    // Duplex power outlet plate or dual side toggles
    if (hole_type == "outlet" || hole_type == "dualsidetoggle") 
    {
            translate([height_sizes[plate_size]/2 + 19.3915,0,0]) 
            {
                difference() {
                    cylinder(r=17.4625, h=15, center = true);
                    translate([-24.2875,-15,-2]) cube([10,37,15], center = false);
                    translate([14.2875,-15,-2]) cube([10,37,15], center = false);
                                    }
                                
            }
            
            translate([height_sizes[plate_size]/2 - 19.3915,0,0])
            {
                difference(){
                    cylinder(r=17.4625, h=15, center = true);
                    translate([-24.2875,-15,-2]) cube([10,37,15], center = false);
                    translate([14.2875,-15,-2]) cube([10,37,15], center = false);
                                    }
            }
            
            translate([height_sizes[plate_size]/2,0,-1]) cylinder(r=2, h=10);
            translate([height_sizes[plate_size]/2,0,3.5]) cylinder(r1=2, r2=3.3, h=3);                    
    }
}




module plate1(){
	if (1st_plate == "toggle" || 1st_plate_bottom_hole == "toggle"){
		translate([0,l_offset[plate_size],0]) toggle_screws();
		translate([0,l_offset[plate_size],0]) hole("toggle");
		}
	else if (1st_plate == "long_toggle" || 1st_plate_bottom_hole == "long_toggle"){
		translate([0,l_offset[plate_size],0]) toggle_screws();
		translate([0,l_offset[plate_size],0]) hole("long_toggle");
		}
	else if (1st_plate == "rocker" || 1st_plate_bottom_hole == "rocker"){
		translate([0,l_offset[plate_size],0]) rocker_screws();
		translate([0,l_offset[plate_size],0]) hole("rocker");
		}
	else if (1st_plate == "outlet" || 1st_plate_bottom_hole == "outlet") {
	translate([0,l_offset[plate_size],0]) hole("outlet");
	}
	else if (1st_plate_bottom_hole == "none") {
		translate([0,l_offset[plate_size],0]) box_screws();
		translate([positions[0],l_offset[plate_size],0]) hole(1st_plate);
			}
	else if (1st_plate == "none") {
		translate([0,l_offset[plate_size],0]) box_screws();
		translate([positions[0],l_offset[plate_size],0]) hole(1st_plate_bottom_hole);
			}
	else {
	translate([0,l_offset[plate_size],0]) box_screws();
	translate([positions[1],l_offset[plate_size],0]) hole(1st_plate);
	translate([positions[2],l_offset[plate_size],0]) hole(1st_plate_bottom_hole);
	}
}





// remove the other stuff
// Hole Cutout definitions
module hole(hole_type) 
{
    echo("hole-1");

// Toggle switch hole
	if (hole_type == "toggle") {
		translate([height_sizes[plate_size]/2,0,0]) cube([23.8125,10.3188,15], center = true);
		 						}

// Toggle switch hole and screw holes
	if (hole_type == "long_toggle") {
		translate([height_sizes[plate_size]/2,0,0]) cube([43.6563,11.9063,15], center = true);
		 						}

// Rocker switch plate
	if (hole_type == "rocker") {
		translate([height_sizes[plate_size]/2,0,0]) cube([67.1,33.3,15], center = true);

		 						}

// Duplex power outlet plate or dual side toggles
	if (hole_type == "outlet" || hole_type == "dualsidetoggle") {
		translate([height_sizes[plate_size]/2 + 19.3915,0,0]) {
			difference() {
				cylinder(r=17.4625, h=15, center = true);
				translate([-24.2875,-15,-2]) cube([10,37,15], center = false);
				translate([14.2875,-15,-2]) cube([10,37,15], center = false);
								}
							}
		translate([height_sizes[plate_size]/2 - 19.3915,0,0]){
			difference(){
				cylinder(r=17.4625, h=15, center = true);
				translate([-24.2875,-15,-2]) cube([10,37,15], center = false);
				translate([14.2875,-15,-2]) cube([10,37,15], center = false);
								}
							}
		translate([height_sizes[plate_size]/2,0,-1]) cylinder(r=2, h=10);
		translate([height_sizes[plate_size]/2,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
							}

// Blank plate
	if (hole_type == "blank") { }

// VGA & DB09 plate
// VGA Fits http://www.datapro.net/products/vga-dual-panel-mount-f-f-cable.html
// DB09 Fits http://www.datapro.net/products/db9-serial-panel-mount-male-extension.html
	if (hole_type == "vga" || hole_type == "db09") {

			translate([0,-12.5,3]) cylinder(r=1.75, h=10, center = true);
			translate([0,12.5,3]) cylinder(r=1.75, h=10, center = true);
				difference(){
					cube([10,19,13], center=true);
					translate([-5,-9.2,1]) rotate([0,0,-35.6]) cube([4.4,2.4,15], center=true);
					translate([.9,-11.2,0]) rotate([0,0,9.6]) cube([10,4.8,15], center=true);
					translate([4.6,-8.5,0]) rotate([0,0,37.2]) cube([4.4,2.4,15], center=true);
					translate([-5,9.2,1]) rotate([0,0,35.6]) cube([4.4,2.4,15], center=true);
					translate([0.9,11.2,0]) rotate([0,0,-9.6]) cube([10,4.8,15], center=true);
					translate([4.6,8.5,0]) rotate([0,0,-37.2]) cube([4.4,2.4,15], center=true);
								}
						}

// HDMI plate
// Fits http://www.datapro.net/products/hdmi-panel-mount-extension-cable.html
	if (hole_type == "hdmi") {
		translate([0,-13,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,13,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([6,16,10], center=true);
							}

// DVI-I plate
// Fits http://www.datapro.net/products/dvi-i-panel-mount-extension-cable.html
	if (hole_type == "dvi") {
		translate([0,-16,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,16,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([10,26,10], center=true);
							}

// DisplayPort plate
// Fits http://www.datapro.net/products/dvi-i-panel-mount-extension-cable.html
	if (hole_type == "displayport") {
		translate([0,-13.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,13.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,0]){
			difference(){
				translate([0,0,3]) cube([7,19,10], center=true);
				translate([2.47,-9.37,3]) rotate([0,0,-54.6]) cube([3,5,14], center=true);
						}
								}
									}

// USB-A Plate
// Fits http://www.datapro.net/products/usb-panel-mount-type-a-cable.html
	if (hole_type == "usb-a") {
		translate([0,-15,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,15,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([8,16,10], center=true);
							}

// USB-B Plate
// Fits http://www.datapro.net/products/usb-panel-mount-type-b-cable.html
	if (hole_type == "usb-b") {
		translate([0,-13,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,13,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([11,12,10], center=true);
							}

// 1394 Firewire Plate
// Fits http://www.datapro.net/products/firewire-panel-mount-extension.html
	if (hole_type == "firewire") {
		translate([0,-13.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,13.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([7,12,10], center=true);
							}

// F-Type / Cable TV Plate
// Fits http://www.datapro.net/products/f-type-panel-mounting-coupler.html
	if (hole_type == "f-type") {
		translate([0,0,3]) cylinder(r=4.7625, h=10, center=true);
							}

// Cat5e & Gat6 plate
// Cat5e Fits http://www.datapro.net/products/cat-5e-panel-mount-ethernet.html
// Cat6 Fits hhttp://www.datapro.net/products/cat-6-panel-mount-ethernet.html
	if (hole_type == "cat5e" || hole_type == "cat6") {
		translate([0,-12.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,12.5,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cube([15,15,10], center=true);
		}

// S-Video & PS2 plate
// S-Video Fits hhttp://www.datapro.net/products/cat-6-panel-mount-ethernet.html
// PS2 http://www.datapro.net/products/ps2-panel-mount-extension-cable.html
	if (hole_type == "svideo" || hole_type == "ps2") {
		translate([0,-10,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,10,3]) cylinder(r=1.75, h=10, center = true);
		translate([0,0,3]) cylinder(r=5, h=10, center=true);
		}


// Stereo / 1/4" headphone jack coupler
// Stereo coupler Fits http://www.datapro.net/products/stereo-panel-mount-coupler.html
	if (hole_type == "stereo") {
		translate([0,0,3]) cylinder(r=2.985, h=10, center=true);
		}

//Keystone1 hole
//Hole for 1 Keystone Jack
	if (hole_type == "keystone1") {
		translate([0,0,5]) cube([16.5,15,10], center = true);
	}

//Keystone Solid
	if (hole_type == "keystone_solid") {
		rotate([0,0,90]) {
			difference(){
				translate([0,0,.1]) cube([23,30.5,9.8]);
					translate([4,4,0]){
						difference(){
							cube([15,22.5,10]);
							translate([-1,-0.001,3.501]) cube([17,2,6.5]);
							translate([-1,2.5,-3.40970]) rotate([45,0,0]) cube([17,2,6.5]);
							translate([-1,18.501,6.001]) cube([17,4,4]);
							translate([-1,20.5,0]) rotate([-45,0,0]) cube([17,2,6.5]);
						}
					}
				}
			}
		}

//End of module "hole"
}
