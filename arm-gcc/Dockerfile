FROM ubuntu:16.04
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ARG ARM_GCC_TGT="gcc-arm-none-eabi-6-2017-q1-update"
ARG ARM_GCC_PKG="$ARM_GCC_TGT-linux"
ARG ARM_SRC_URL="https://developer.arm.com/-/media/Files/downloads/gnu-rm/6_1-2017q1/$ARM_GCC_PKG.tar.bz2"

ENV DEBIAN_FRONTEND noninteractive

ENV DEPS \
	apt-utils \
	ca-certificates \
	curl \
	wget \
	mlocate \
	xz-utils \
	unzip \
	vim \
	ssh \
	git \
	bzip2 \
	make \
	cmake 

RUN apt-get update && apt-get install -y $DEPS --no-install-recommends

RUN mkdir -p /opt

RUN curl -sSL $ARM_SRC_URL > /opt/$ARM_GCC_PKG.tar.bz2

WORKDIR /opt

RUN bunzip2 $ARM_GCC_PKG.tar.bz2 \
	&& tar -v -xf $ARM_GCC_PKG.tar \
	&& ln -s $ARM_GCC_TGT gcc-arm-none-eabi \
	&& rm -f $ARM_GCC_PKG.tar

RUN echo "export PATH=\"/opt/gcc-arm-none-eabi/bin:$PATH\"" >> /etc/bash.bashrc

RUN curl -sSL https://github.com/gnuarmeclipse/openocd/releases/download/gae-0.10.0-20170418/gnuarmeclipse-openocd-debian64-0.10.0-201704182147-dev.tgz > gnuarmeclipse-openocd-debian64-0.10.0-201704182147-dev.tgz
RUN tar -zxf gnuarmeclipse-openocd-debian64-0.10.0-201704182147-dev.tgz \
	&& rm -f gnuarmeclipse-openocd-debian64-0.10.0-201704182147-dev.tgz \
	&& mkdir openocd \
	&& cp -rp gnuarmeclipse/openocd/0.10.0-201704182147-dev/* openocd/ \
	&& rm -rf gnuarmeclipse

RUN echo "export PATH=\"/opt/openocd/bin:$PATH\"" >> /etc/bash.bashrc

RUN mkdir /workspace
WORKDIR /workspace

ENV OPENOCD_SCRIPTS="/opt/openocd/scripts"

EXPOSE 4444:4444
VOLUME /dev/bus/usb

