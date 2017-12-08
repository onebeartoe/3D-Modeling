
use <../external-resources/thumbnails/thumbnails-by-name.scad>
use <../shapes/thumbnails/thumbnails-by-name.scad>

module thumbnailByName(iconName)
{
	if(iconName == "arrow")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "bat")
	{
		externalResources_thumbnailByName(iconName);
	}
	else if(iconName == "cat")
	{
		externalResources_thumbnailByName(iconName);
	}
	else if(iconName == "clover")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "dialog-bubble")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "heart")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "pacman")
	{
		externalResources_thumbnailByName(iconName);
	}
	else if(iconName == "rebel")
	{
		externalResources_thumbnailByName(iconName);
	}
	else if(iconName == "spur")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "star")
	{
		shapes_thumbnailByName(iconName);
	}
	else if(iconName == "thundercat")
	{
		externalResources_thumbnailByName(iconName);
	}
	else if(iconName == "trooper")
	{
		externalResources_thumbnailByName(iconName);
	}
	else
	{
		echo("No thumbnail was found.");
	}
}
