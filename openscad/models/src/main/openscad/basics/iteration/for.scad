
step = 1;

yStart = 1;
yEnd = 5;

zStart = 1;
zEnd = 3;

for(y = [yStart : step : yEnd],
	z = [zStart : step : zEnd])
{
	separateor = " - ";

	echo(y, separateor, z);
}

/*
	expected output:

	ECHO: 1, " - ", 1
	ECHO: 1, " - ", 2
	ECHO: 1, " - ", 3
	ECHO: 2, " - ", 1
	ECHO: 2, " - ", 2
	ECHO: 2, " - ", 3
	ECHO: 3, " - ", 1
	ECHO: 3, " - ", 2
	ECHO: 3, " - ", 3
	ECHO: 4, " - ", 1
	ECHO: 4, " - ", 2
	ECHO: 4, " - ", 3
	ECHO: 5, " - ", 1
	ECHO: 5, " - ", 2
	ECHO: 5, " - ", 3
*/

// the end condition is inclusive, so the following will have three iterations:

iStep = 1;

for(i = [1 : iStep : 3])
{
	echo(i);
}

/*
	expected output:

	ECHO: 1
	ECHO: 2
	ECHO: 3

*/
