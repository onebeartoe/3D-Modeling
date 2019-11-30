#!/bin/bash

set -ev

#sudo cp openscad.list /etc/apt/sources.list.d/
#ls -la /etc/apt/sources.list.d/openscad.list

wget -qO - https://files.openscad.org/OBS-Repository-Key.pub | sudo apt-key add -

#sudo add-apt-repository --yes ppa:openscad/releases
sudo apt-get update -qq

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y snapd

sudo snap install openscad-nightly

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y imagemagick xvfb
#sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openscad-nightly imagemagick xvfb


#TODO: renable this once night is working
#sudo apt-get install -y openscad-mcad

which openscad-nightly
whereis openscad-nightly

#TODO: renable this once night is working
#whereis openscad-mcad

ls -la /usr/bin/openscad-nightly

ls -la /usr/share/openscad-nightly

#TODO: renable this once night is working
#ls -la /usr/share/openscad-nightly/libraries
