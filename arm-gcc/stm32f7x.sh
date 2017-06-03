#!/bin/bash

docker run -d -P --privileged \
	-p 4444:4444 \
	-e "OPENOCD_SCRIPTS=/opt/openocd/scripts" \
	-t arm-gcc:latest \
	/opt/openocd/bin/openocd \
		-f interface/stlink-v2-1.cfg \
		-f target/stm32f7x.cfg

