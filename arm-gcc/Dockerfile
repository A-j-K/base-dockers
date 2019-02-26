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
	sudo \
	cmake 

ENV BUILD_TOOLS_ENV \
	openjdk-8-jdk \
	openjdk-8-jre \
	gcc-arm-embedded \
	openocd \
	eclipse-cdt \
	eclipse-cdt-autotools \
	eclipse-cdt-jni \
	eclipse-cdt-launch-remote \
	eclipse-cdt-perf \
	eclipse-cdt-pkg-config \
	eclipse-cdt-profiling-framework \
	eclipse-cdt-profiling-framework-remote \
	eclipse-cdt-valgrind 

ENV OPENOCD_SCRIPTS=/usr/share/openocd/scripts

RUN apt-get update \
	&& apt-get install -y $DEPS --no-install-recommends \
	&& add-apt-repository -y ppa:team-gcc-arm-embedded/ppa \
	&& apt-get update \
	&& apt-get install -y $BUILD_TOOLS_ENV --no-install-recommends \
	&& groupadd -r developer  && useradd -r -g developer developer \
	&& mkdir -p /home/developer \
	&& chown -R developer:developer /home/developer \
	&& chmod 0755 /home/developer \
	&& mkdir /workspace \
	&& chown -R developer:developer /workspace \
	&& echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer \
	&& chmod 0440 /etc/sudoers.d/developer
		
WORKDIR /workspace
EXPOSE 4444:4444
VOLUME /dev/bus/usb

