#!/bin/sh
set -e
cd /src
mkdir -p build
cd build
cmake -GNinja .. "$@"
cmake --build .
