#!/bin/sh

version=0.0.1

mkdir out
cp -rv src out/heat-pipe-thermometer

zip -9r out/heat-pipe-thermometer-${version}.zip out/heat-pipe-thermometer

ls -lh out
