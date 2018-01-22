#!/bin/bash

AWS_SDK_CPP_VER="1.3.42"

docker build \
	--build-arg AWS_SDK_CPP_VER=$AWS_SDK_CPP_VER \
	--tag aws-sdk-cpp:${AWS_SDK_CPP_VER} \
	.

