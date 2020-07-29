#!/bin/sh
DOCKER_IMAGE="$(docker build -q .)"
echo $DOCKER_IMAGE
docker run --rm -it -v "$PWD:/src" "$DOCKER_IMAGE" /container_build.sh "$@"
