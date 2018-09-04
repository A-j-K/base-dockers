FROM ubuntu:18.04
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ENV DEBIAN_FRONTEND noninteractive

ENV DEPS \
	apt-utils \
	ca-certificates \
	software-properties-common \
	curl \
	wget \
	mlocate \
	xz-utils \
	unzip \
	vim \
	ssh \
	git \
	screen \
	bzip2 \
	make \
	cmake 

RUN apt-get update \
	&& apt-get install -y $DEPS --no-install-recommends \
	&& add-apt-repository -y ppa:team-gcc-arm-embedded/ppa \
	&& apt-get update \
	&& apt-get install -y gcc-arm-embedded openocd eclipse

RUN mkdir /workspace
WORKDIR /workspace

EXPOSE 4444:4444
VOLUME /dev/bus/usb

