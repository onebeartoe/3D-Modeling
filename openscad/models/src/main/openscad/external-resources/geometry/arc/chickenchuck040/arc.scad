
// This arc module is from this thing on Thingiverse:
//		https://www.thingiverse.com/thing:1092611

module arc(radius, thick, angle)
{
	intersection()
	{
		union()
		{
			rights = floor(angle/90);
			remain = angle-rights*90;
			if(angle > 90)
			{
				for(i = [0:rights-1]){
					rotate(i*90-(rights-1)*90/2){
						polygon([[0, 0], [radius+thick, (radius+thick)*tan(90/2)], [radius+thick, -(radius+thick)*tan(90/2)]]);
					}
				}
				rotate(-(rights)*90/2)
					polygon([[0, 0], [radius+thick, 0], [radius+thick, -(radius+thick)*tan(remain/2)]]);
				rotate((rights)*90/2)
					polygon([[0, 0], [radius+thick, (radius+thick)*tan(remain/2)], [radius+thick, 0]]);
			}
			else
			{
				polygon([[0, 0], [radius+thick, (radius+thick)*tan(angle/2)], [radius+thick, -(radius+thick)*tan(angle/2)]]);
			}
		}
		difference(){
			circle(radius+thick, $fn = 40);
			circle(radius, $fn = 40);
		}
	}
}

//arc(10, 3, 300);