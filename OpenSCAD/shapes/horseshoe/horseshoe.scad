
module horseshoeProjection()
{
	rotate ([0, 0, 90])
	translate ([45, 0, 0]) 
	projection(cut=true) // the projection is from http://blog.bangsplatpresents.com/?p=1123
	{
		translate( v=[0,0,25] ) 
		{
			rotate( a=[0,45,0] ) 
			{
				cylinder( r1=25, r2=0, h=100, center=true );
			}
		}
	}
}

module horseshoe()
{
	linear_extrude(height=10)
	difference() 
	{ 
		horseshoeProjection();
		
		translate ([0, -1, 0])
		scale ([0.85, .9, 1]) 
		horseshoeProjection();
	}
}

horseshoe();
