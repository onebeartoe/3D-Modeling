

openOval = function(innerRadius)
{
	return difference(
          cylinder({r: 4 + innerRadius, h: 10}),
		  cylinder({r: innerRadius, h: 11})
       );
}

openOvalReal = function(innerRadius)
{
	return cylinder({r: innerRadius, h: 10});
}
