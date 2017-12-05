
use <../../shapes/heart/heart.scad>
use <../../shapes/spurs/spurs-a.scad>

module shapes_thumbnailByName(iconName)
{
	if(iconName == "heart")
	{
	//                scale([icon1_scale, icon1_scale, zScale])
			heartThumbnail();
	}
	else if(iconName == "spur")
	{
			spurThumbnail();
	}
	else
	{
		echo("No shape thumbnail was found");
	}
}
