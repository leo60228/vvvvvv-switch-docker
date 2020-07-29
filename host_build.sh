#!/bin/sh
DOCKER_IMAGE="$(docker build -q .)"
echo $DOCKER_IMAGE
docker run --rm -v "$PWD:/src" "$DOCKER_IMAGE"
