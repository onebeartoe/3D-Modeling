
# might use xargs
#find . -type f -iname "*.scad" -print0 | xargs -0 ls -la

# pipe to xargs
#./find-oscad-files.sh | xargs ls -la

# Import the global variables.
source ./global-variables.sh

# make sure each OpenSCAD file has a corresponding 'baseline' image
./find-oscad-files.sh | ./data-set-test.sh

# CHECK THE ERRROR CODE TO CONTINUE!!!!!!!!!!!
echo "(*&^%$#$%^&*())exit code: $?"                        

# generate a proposed version of the .png  from .oscad file
./find-oscad-files.sh | ./generate-proposed-pngs.sh
echo "The proposed baseline files are generated."

# Compare the baseline PNG to the proposed PNG.
./find-oscad-files.sh | ./compare-pngs.sh
#!!!!!!!!!!check if the diff are good!!!  Dohast!  Nien!

#

echo "Thanks for using the onebeartoe test suite for OpenSCAD libraries."
