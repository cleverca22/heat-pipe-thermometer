#!/bin/sh

version=0.0.2

mkdir out
cp -rv src out/heat-pipe-thermometer

cd out
zip -9r heat-pipe-thermometer-${version}.zip heat-pipe-thermometer

ls -lh
