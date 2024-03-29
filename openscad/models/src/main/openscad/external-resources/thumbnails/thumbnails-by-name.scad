
use <../../external-resources/batman/batman.scad>
use <../../external-resources/cat/cat.scad>
use <../../external-resources/dogs/doge/doge.scad>
use <../../external-resources/pacman/pacman.scad>
use <../../external-resources/oshw/oshw-logo-800-px.scad>
use <../../external-resources/rebel-alliance/rebel-alliance.scad>
use <../../external-resources/thundercats/thundercats-logo.scad>
use <../../external-resources/trooper/scrum-trooper.scad>
use <../../external-resources/star-trek/logo/star-trek-logo.scad>

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
	else if(iconName == "doge")
	{
		dogeThumbnail();
	}
	else if(iconName == "pacman")
	{
		pacmanThumbnail();
	}
	else if(iconName == "oshw")
	{
		oshwLogoThumbnail();
	}
	else if(iconName == "rebel")
	{
		rebelAllianceThumbnail();
	}
	else if(iconName == "star-trek")
	{
		starTrekLogoThumbnail();
	}
	else if(iconName == "thundercat")
	{
		thundercatsLogoThumbnail();
	}
	else if(iconName == "trooper")
	{
		scrumTrooperThumbnail();
	}
	else
	{
		echo("No external resource thumbnail was found");
	}
}
