
# pipe all proposed baseline PNG file names to the while loop
find . -type f -iname "*-proposed-baseline.png" -printf '%P\n' |

while read line
do

	# remove the '.oscad' from the file name
	baseName=${line::-22}
	
	targetName=$baseName".scad"

	if   [ ! -f $targetName ] # test to see if the corresponding .scad file exists
	then
	
		echo "missing input file: $targetName for a proposed baseline PNG: $line"
		
	fi	
	
done