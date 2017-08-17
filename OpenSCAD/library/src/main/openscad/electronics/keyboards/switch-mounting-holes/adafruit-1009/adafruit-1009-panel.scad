
use <../../mounting-plates/keyboard-switch-mounting-plate.scad>

// adafruit tactile buttons:
//
//	https://www.adafruit.com/product/1009
//	https://www.adafruit.com/product/1010
buttonSide = 12; // 12mm based on the details from the Adafruit site

keyboardSwitchMountingPlate(boardLength = 30,
              boardWidth = 60,
              buttonCount = 4,
              buttonSide = buttonSide,
              cornerRadius = 3,
              panelHeight = 1);
