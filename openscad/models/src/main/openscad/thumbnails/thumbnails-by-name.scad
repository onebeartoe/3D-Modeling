
use <../external-resources/thumbnails/thumbnails-by-name.scad>
use <../shapes/thumbnails/thumbnails-by-name.scad>

module thumbnailByName(iconName)
{
	if(iconName == "heart")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "bat")
	{
		externalResources_thumbnailByName(iconName);
	}
}
