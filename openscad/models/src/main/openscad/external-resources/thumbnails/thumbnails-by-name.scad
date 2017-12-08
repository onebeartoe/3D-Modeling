
use <../../external-resources/batman/batman.scad>
use <../../external-resources/rebel-alliance/rebel-alliance.scad>

module externalResources_thumbnailByName(iconName)
{
	if(iconName == "bat")
	{
	//                scale([icon1_scale, icon1_scale, zScale])
			batmanLogoThumbnail();
	}
	else if(iconName == "rebel")
	{
		rebelAllianceThumbnail();
	}
}
