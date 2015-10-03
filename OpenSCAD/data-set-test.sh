
# iteration over stanard input example: http://stackoverflow.com/questions/6980090/how-to-read-from-file-or-stdin-in-bash

allFilesPresent=true;

while read line
do

	# remove the '.oscad' from the file name
	baseName=${line::-5}
	
	# concatinate '.png' to the base name
	targetName="$baseName.png"

	if   [ ! -f $targetName ] # test to see if the base comparison file exists
	then
	
		echo "missing input file: $targetName"
		
		allFilesPresent=false
	fi

done < "${1:-/dev/stdin}"

# assume the data set is complete and set the exit code to succeeded status
exitCode=0
	
if [ "$allFilesPresent" == true ]
then
		echo "All input files present."
else
		#set a exit code to indicate the data set was not complete
		exitCode=1
		
		echo "The test suite detected that some input files are not present."
fi

exit $exitCode
