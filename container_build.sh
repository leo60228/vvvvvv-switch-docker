#!/bin/sh
set -e
git config --global --add safe.directory '*'
cd /src
mkdir -p build
cd build
cmake -GNinja .. "$@"
cmake --build .
