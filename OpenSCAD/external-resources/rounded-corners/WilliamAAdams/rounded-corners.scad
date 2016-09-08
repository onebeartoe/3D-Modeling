
/**

	Source code source:
	
		http://www.thingiverse.com/thing:9347
		
*/

// You could simply do it this way if you have the boxes.scad
// file in your library
//use <boxes.scad>
//roundedBox([20, 30, 40], 5, true); 

// Or, you could do it this way if you want to roll your own
// THIS ONE
//roundedRect([20, 30, 40], 5, $fn=12);

miniround([20, 30, 40], 5, $fn=12);

// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}		





module miniround(size, radius)
{
$fn=50;
x = size[0]-radius/2;
y = size[1]-radius/2;

minkowski(size, radius)
{
    cube(size=[x,y,size[2]]);
//    cylinder(r=radius);
    // Using a sphere is possible, but will kill performance
    sphere(r=radius);
}

}