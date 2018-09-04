#!/bin/bash

docker run -d -P --privileged \
	-p 4444:4444 \
	-e "OPENOCD_SCRIPTS=/usr/share/openocd/scripts" \
	-t arm-gcc:latest \
	openocd \
		-f interface/stlink-v2-1.cfg \
		-f target/stm32f7x.cfg

