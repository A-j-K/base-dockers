#!/bin/bash

AWS_CPP_SDK_VER="1.3.43"
PROXYGEN_VER="2018.01.22.00"

sed -e "s@__AWS_CPP_SDK_VER__@${AWS_CPP_SDK_VER}@g" Dockerfile_template > Dockerfile

docker build \
	--build-arg PROXYGEN_VER="$PROXYGEN_VER" \
	-t proxygen-with-aws-sdk:${PROXYGEN_VER}-${AWS_CPP_SDK_VER} \
	. \
	&& rm -f Dockerfile \
	&& echo "Use the following to update the Docker Hub repository" \
	&& echo "  docker login" \
	&& echo "  docker tag proxygen-with-aws-sdk:${PROXYGEN_VER}-${AWS_CPP_SDK_VER} andykirkham/proxygen-with-aws-sdk:${PROXYGEN_VER}-${AWS_CPP_SDK_VER}" \
	&& echo "  docker push andykirkham/proxygen-with-aws-sdk:${PROXYGEN_VER}-${AWS_CPP_SDK_VER}"

