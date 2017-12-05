
use <../../dialog-bubble.scad>

module stencilDialogBubble()
{
	difference()
	{
		dialogBubble(yLength = 15);

		stencilDialogBubble_lines();
	}
}

module stencilDialogBubble_lines()
{
	
}
