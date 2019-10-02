#!/bin/bash

set -ev

sudo add-apt-repository --yes ppa:openscad/releases
sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openscad imagemagick xvfb

sudo apt-get install -y openscad-mcad

which openscad
whereis openscad

ls -la /usr/bin/openscad

ls -la /usr/share/openscad
