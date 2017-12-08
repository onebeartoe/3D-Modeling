
use <../../external-resources/batman/batman.scad>
use <../../external-resources/cat/cat.scad>
use <../../external-resources/rebel-alliance/rebel-alliance.scad>
use <../../external-resources/thundercats/thundercats-logo.scad>

module externalResources_thumbnailByName(iconName)
{
	if(iconName == "bat")
	{
			batmanLogoThumbnail();
	}
	else if(iconName == "cat")
	{
		catThumbnail();
	}
	else if(iconName == "rebel")
	{
		rebelAllianceThumbnail();
	}
	else if(iconName == "thundercat")
	{
		thundercatsLogoThumbnail();
	}
	else
	{
		echo("No external resource thumbnail was found");
	}
}
