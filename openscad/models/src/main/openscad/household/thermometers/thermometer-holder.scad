

module thermometer_holder(backplateHeight = 4)
{
    cube([10,30,3]);

    for (a =[-10:110])
    {
        echo(a);

        color("blue")
        translate([0,a*3,0])
        tick();
    }

}

module tick()
{
    cube([5,2,2]);
}


