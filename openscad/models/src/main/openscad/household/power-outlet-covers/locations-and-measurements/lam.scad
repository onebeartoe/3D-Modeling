
// Bigger hole in your wall? Try this
plate_size = 0; // [0:Standard, 1:Junior-Jumbo, 2:Jumbo]

height_sizes = [114.3,123.825,133.35];

// Toggle screw holes
module toggle_screws(height_sizes = [114.3], 
                     plate_size = 0)
{
	 translate([height_sizes[plate_size]/2 + 30.1625,0,-1]) 
     cylinder(r=2, h=10, $fn=12);

	 translate([height_sizes[plate_size]/2 + 30.1625,0,3.5]) 
     cylinder(r1=2, r2=3.3, h=3);
	 
     // other part
	 translate([height_sizes[plate_size]/2 - 30.1625,0,-1]) cylinder(r=2, h=10, $fn=12);
	 translate([height_sizes[plate_size]/2 - 30.1625,0,3.5]) cylinder(r1=2, r2=3.3, h=3);
}
