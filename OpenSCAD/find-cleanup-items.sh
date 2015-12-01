

function findfiles
{
	# pipe all proposed baseline PNG file names to the while loop
	find . -type f -iname "*$1" -printf '%P\n' |

	while read line
	do

		# remove the '.oscad' from the file name
		baseName=${line::-$2}
			
		targetName=$baseName".scad"

		if   [ ! -f $targetName ] # test to see if the corresponding .scad file exists
		then
		
			echo "missing input file: $targetName for a proposed baseline PNG: $line"
			
		fi	
		
	done
}

# call the function
findfiles -proposed-baseline.png 22

# this next one does not work (as is) because the -baseline.png picks up the -propossed-baseline.png files as well :(
#findfiles -baseline.png 13