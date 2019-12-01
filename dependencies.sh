#!/bin/bash

set -ev

sudo cp openscad.list /etc/apt/sources.list.d/
ls -la /etc/apt/sources.list.d/openscad.list

wget -qO - https://files.openscad.org/OBS-Repository-Key.pub | sudo apt-key add -

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5

sudo add-apt-repository --yes ppa:openscad/releases
sudo apt-get update -qq

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjfx

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openscad-nightly imagemagick xvfb

sudo mkdir /usr/share/openscad-nightly/libraries

sudo apt-get install -y openscad-mcad

sudo updatedb

locate mcad
locate triangles.scad

cp -r /usr/share/openscad/libraries/MCAD/ /usr/share/openscad-nightly/libraries/

ls -la /usr/share/openscad

which openscad-nightly

whereis openscad-nightly

whereis openscad-mcad

ls -la /usr/share/openscad-nightly/
ls -la /usr/share/openscad-nightly/libraries
