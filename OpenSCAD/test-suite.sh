
# next is the executable for OpenSCAD
#  /cygdrive/c/opt/OpenSCAD/openscad-2015.03-1/openscad -o ring.png ring.scad

# might use xargs
#find . -type f -iname "*.scad" -print0 | xargs -0 ls -la

# pipe to xargs
#./find-oscad-files.sh | xargs ls -la

# make sure each OpenSCAD file has a corresponding 'current' image
./find-oscad-files.sh | ./data-set-test.sh

echo "exit code: $?"                        

exit

echo 'end of run'  # with the call to exit in place, execution does not reach here