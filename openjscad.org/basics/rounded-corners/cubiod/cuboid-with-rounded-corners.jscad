function getParameterDefinitions() {
  return [
    { name: 'width', type: 'float', initial: 10, caption: "Width of the cube:" },
    { name: 'height', type: 'float', initial: 14, caption: "Height of the cube:" },
    { name: 'depth', type: 'float', initial: 7, caption: "Depth of the cube:" },
    { name: 'rounded', type: 'choice', caption: 'Round the corners?', values: [1, 0], captions: ["Yes please", "No thanks"], initial: 1 }
  ];
}

function main(params)
{
  var result;
  if(params.rounded == 1)
  {
    bottom =
//union(
    difference(
        CSG.roundedCube({radius: [params.width, params.height, params.depth],
                         roundradius: 2, resolution: 32}),

        CSG.roundedCube({radius: [params.width-2, params.height-2, params.depth],
                         roundradius: 2, resolution: 32})
                         .translate([0,0,2])
    )
    ;

    result = bottom;

  } else {
    result = CSG.cube({radius: [params.width, params.height, params.depth]});
  }
  return result;
}
