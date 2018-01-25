#!/bin/bash

PROXYGEN_VER="2018.01.22.00"

docker build \
	--build-arg PROXYGEN_VER="$PROXYGEN_VER" \
	-t proxygen-with-aws-sdk:${PROXYGEN_VER} \
	.

echo "Use the following to update the Docker Hub repository"
echo "  docker login"
echo "  docker tag proxygen-with-aws-sdk:${PROXYGEN_VER} andykirkham/proxygen-with-aws-sdk:${PROXYGEN_VER}"
echo "  docker push andykirkham/proxygen-with-aws-sdk:${PROXYGEN_VER}"

