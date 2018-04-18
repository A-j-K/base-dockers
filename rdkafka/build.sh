#!/bin/bash

VERSION="0.11.4"

docker build \
	-t rdkafka:$VERSION \
	--build-arg VERSION=$VERSION \
	. 
echo "docker tag rdkafka:$VERSION andykirkham/rdkafka:$VERSION"
echo "docker push andykirkham/rdkafka:$VERSION"

