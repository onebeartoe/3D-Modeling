#!/bin/bash

set -ev

sudo cp openscad.list /etc/apt/sources.list.d/
ls -la /etc/apt/sources.list.d/openscad.list

wget -qO - https://files.openscad.org/OBS-Repository-Key.pub | sudo apt-key add -

#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5

#sudo add-apt-repository --yes ppa:openscad/releases
#sudo apt-get update -qq

#sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libopencsg1v5:i386 libopencsg1v5

#sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjfx

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openscad imagemagick xvfb

sudo mkdir /usr/share/openscad/libraries

sudo apt-get install -y openscad-mcad

sudo cp -r /usr/share/openscad/libraries/MCAD/ /usr/share/openscad/libraries/

ls -la /usr/share/openscad

which openscad

whereis openscad

whereis openscad-mcad

ls -la /usr/share/openscad/
ls -la /usr/share/openscad/libraries
