#!/bin/bash

source ./ver.bash

docker build \
	--build-arg AWS_SDK_CPP_VER_MAJOR=$AWS_SDK_CPP_VER_MAJOR \
	--build-arg AWS_SDK_CPP_VER_MINOR=$AWS_SDK_CPP_VER_MINOR \
	--build-arg AWS_SDK_CPP_VER_PATCH=$AWS_SDK_CPP_VER_PATCH \
	--build-arg CMAKE_VER_MAJOR="3" \
	--build-arg CMAKE_VER_MINOR="10" \
	--build-arg CMAKE_VER_PATCH="2" \
	--build-arg BUILD_SHARED_LIBS="OFF" \
	--build-arg ENABLE_UNITY_BUILD="ON" \
	--tag aws-sdk-cpp-static:${AWS_SDK_CPP_VERSION} \
	.

echo "Use the following to update the Docker Hub repository"
echo "  docker login"
echo "  docker tag aws-sdk-cpp-static:${AWS_SDK_CPP_VERSION} andykirkham/aws-sdk-cpp:static-${AWS_SDK_CPP_VERSION}"
echo "  docker push andykirkham/aws-sdk-cpp:static-${AWS_SDK_CPP_VERSION}"

