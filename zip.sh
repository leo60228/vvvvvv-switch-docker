#!/bin/sh
set -e
cd build
rm -rf zip VVVVVV.zip
mkdir zip
cd zip
mkdir VVVVVV
cp ../VVVVVV/desktop_version/VVVVVV.nro VVVVVV/
cp -r ../../VVVVVV/desktop_version/fonts ../../VVVVVV/desktop_version/lang VVVVVV/
zip -r ../VVVVVV.zip VVVVVV/
