#!/bin/bash
REPO=${1:-"andykirkham"}
VERSION="0.1"

docker build \
	-t splinter-build:$VERSION \
	. 

echo "docker tag splinter-build:$VERSION $REPO/splinter-build:$VERSION"
echo "docker push $REPO/splinter-build:$VERSION"

