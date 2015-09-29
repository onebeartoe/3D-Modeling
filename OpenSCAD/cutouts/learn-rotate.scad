
spurStl = "../../lamp-shade-scallops/spur/spurs-a.stl";

//littleSpurCount = 6;

littleSpurScale = 0.125;

// goodie
for ( i = [0 : 5] )
{
//    rotate( i * 360 / 6, [0, 0, 1])
        rotate([
                90, 
                0,
                i * 360 / 6
    ])
    translate([15, 30, 30])

    scale([littleSpurScale, littleSpurScale, 0.2])
        import(spurStl)
    ;
}

 for ( i = [0:5] ) 
 {
  rotate(  
     [
        90,
       0,
        i*360/6
     ]
  )
   translate( [30, 30, 0] ) 
     scale([littleSpurScale, littleSpurScale, 0.2])
        import(spurStl)
//     sphere(3)
     ;
 }