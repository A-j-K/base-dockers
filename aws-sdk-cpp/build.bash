#!/bin/bash

AWS_SDK_CPP_VER_MAJOR="1"
AWS_SDK_CPP_VER_MINOR="3"
AWS_SDK_CPP_VER_PATCH="43"
AWS_SDK_CPP_VERSION="${AWS_SDK_CPP_VER_MAJOR}.${AWS_SDK_CPP_VER_MINOR}.${AWS_SDK_CPP_VER_PATCH}"

docker build \
	--build-arg AWS_SDK_CPP_VER_MAJOR=$AWS_SDK_CPP_VER_MAJOR \
	--build-arg AWS_SDK_CPP_VER_MINOR=$AWS_SDK_CPP_VER_MINOR \
	--build-arg AWS_SDK_CPP_VER_PATCH=$AWS_SDK_CPP_VER_PATCH \
	--build-arg CMAKE_VER_MAJOR="3" \
	--build-arg CMAKE_VER_MINOR="10" \
	--build-arg CMAKE_VER_PATCH="2" \
	--tag aws-sdk-cpp:${AWS_SDK_CPP_VERSION} \
	.

echo "Use the following to update the Docker Hub repository"
echo "  docker login"
echo "  docker tag aws-sdk-cpp:${AWS_SDK_CPP_VERSION} andykirkham/aws-sdk-cpp:${AWS_SDK_CPP_VERSION}"
echo "  docker push andykirkham/aws-sdk-cpp:${AWS_SDK_CPP_VERSION}"

