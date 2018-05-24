#!/bin/bash
REPO=${1:-"andykirkham"}
VERSION="0.11.4"

docker build \
	-t rdkafka:$VERSION \
	--build-arg VERSION=$VERSION \
	. 
echo "docker tag rdkafka:$VERSION $REPO/rdkafka:$VERSION"
echo "docker push $REPO/rdkafka:$VERSION"

