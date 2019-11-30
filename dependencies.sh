#!/bin/bash

set -ev

sudo cp openscad.list /etc/apt/sources.list.d/
#ls -la /etc/apt/sources.list.d/openscad.list

wget -qO - https://files.openscad.org/OBS-Repository-Key.pub | sudo apt-key add -

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5

sudo add-apt-repository --yes ppa:openscad/releases
sudo apt-get update -qq

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjfx
#sudo snap install openscad-nightly

#sudo DEBIAN_FRONTEND=noninteractive apt-get install -y imagemagick xvfb
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openscad-nightly imagemagick xvfb

#ls -la /usr/bin
#locate openscad-nightly

#TODO: renable this once night is working
sudo apt-get install -y openscad-mcad

#TODO: renable this once night is working
#which openscad-nightly
#TODO: renable this once night is working
#whereis openscad-nightly

#TODO: renable this once night is working
#whereis openscad-mcad

#ls -la /usr/bin/openscad-nightly

#ls -la /usr/share/openscad-nightly

#TODO: renable this once night is working
ls -la /usr/share/openscad-nightly/libraries
