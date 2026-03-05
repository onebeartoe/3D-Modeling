
module frontRightInnerBatteryCover(base_leg=20, vertical_leg=30, leg_width=5, height=10)
{
    union() {
        // Vertical leg
        cube(size=[leg_width, vertical_leg, height]);
        // Base leg
        cube(size=[base_leg, leg_width, height]);
    }
}
