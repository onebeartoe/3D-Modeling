
module balloon()
{
	union () 
	{
		// balloon
		scale ([0.8, 1, 1]) 
		cylinder (h = 4, r=10, center = true, $fn=100);
		
		// middle knot piece
		knotPiece();

		// left knot piece
		rotate ([0, 0, -6.5])
		knotPiece();
		
		// right knot piece
		rotate ([0, 0, 6.5])
		knotPiece();
	}	
}

module knotPiece()
{
	translate ([0, -10.5, 0]) 
	scale ([0.3, 0.8, 1]) 
	cylinder (h = 4, r=2, center = true, $fn=100);
}

translate ([0, 12, 0])
balloon();