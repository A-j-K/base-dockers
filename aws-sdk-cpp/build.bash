#!/bin/bash

AWS_SDK_CPP_VER="1.0.65"

docker build --build-arg AWS_SDK_CPP_VER=$AWS_SDK_CPP_VER -t aws-sdk-cpp:${AWS_SDK_CPP_VER} .

