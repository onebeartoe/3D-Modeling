
# Import the global variables.
source ./global-variables.sh

# make sure each OpenSCAD file has a corresponding 'baseline' image
./find-oscad-files.sh | ./data-set-test.sh

# obtain the error code
dataSetExitCode=$?

if   [ "$dataSetExitCode" -ne 0 ] # test exit code of the data set test again success code, 0
then
	echo "The test suite will not continue with missing baseline PNG images."
	
	exit
fi

# generate a proposed version of the .png  from .oscad file
./find-oscad-files.sh | ./generate-proposed-pngs.sh
echo "The proposed baseline files are generated."

# Compare the baseline PNG to the proposed PNG.
./find-oscad-files.sh | ./compare-pngs.sh

# Check if the diff are good.
diffComparisonExitCode=$?
if   [ "$diffComparisonExitCode" -ne 0 ]
then
	echo "The test suite detected errors with the baseline and proposed baseline PNG images."
	echo "See the 'Binary files ... differ' message(s) above."

	# return a error exit code
	exit 3
fi

echo "No test suite erros were detected."
echo "Thanks for using the onebeartoe test suite for OpenSCAD libraries."