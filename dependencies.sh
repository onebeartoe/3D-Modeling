#!/bin/bash

set -ev

sudo cp openscad.list /etc/apt/sources.list.d/
ls -la /etc/apt/sources.list.d/openscad.list

sudo add-apt-repository --yes ppa:openscad/releases
sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openscad-nightly imagemagick xvfb

sudo apt-get install -y openscad-mcad

which openscad
whereis openscad

whereis openscad-mcad

ls -la /usr/bin/openscad

ls -la /usr/share/openscad

ls -la /usr/share/openscad/libraries
