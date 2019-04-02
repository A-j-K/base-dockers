#!/bin/bash

docker run --rm -P --privileged \
	-e DISPLAY=$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v ~/.eclipse-docker:/home/developer \
	-v `pwd`:/workspace \
	-p 4444:4444 \
	-u developer \
	-it arm-gcc:latest bash

