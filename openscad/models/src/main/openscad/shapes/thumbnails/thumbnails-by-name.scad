
use <../../shapes/arrow/arrow.scad>
use <../../shapes/clover/clover.scad>
use <../../shapes/dialog-bubble/stencil/stencil-dialog-bubble.scad>
use <../../shapes/heart/heart.scad>
use <../../shapes/spurs/spurs-a.scad>
use <../../shapes/star/star.scad>

module shapes_thumbnailByName(iconName)
{
	if(iconName == "arrow")
	{
		rightArrowThumbnail();
	}
	else if(iconName == "clover")
	{
		cloverThumbnail();
	}
	else if(iconName == "dialog-bubble")
	{
		stenciledDialogBubbleThumbnail();
	}
	else if(iconName == "heart")
	{
		heartThumbnail();
	}
	else if(iconName == "spur")
	{
		spurThumbnail();
	}
	else if(iconName == "star")
	{
		starThumbnail();
	}
	else
	{
		echo("No shape thumbnail was found");
	}
}
