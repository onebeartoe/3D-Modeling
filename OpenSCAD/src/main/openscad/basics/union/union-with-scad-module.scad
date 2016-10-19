
use <../../external-resources/trooper/scrum-trooper.scad>;

union()
{
	color("black")
	cube ([160, 40, 3]);

	troopers();	
}

module troopers()
{
	for(x = [1:4])
	{
		translate([5+x*35, 20, 0])
		color("white")
		scale([1,1,4])
		scrumtrooper(4);
		
		
	}
}