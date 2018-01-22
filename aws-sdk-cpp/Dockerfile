FROM ubuntu:16.04
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ARG AWS_SDK_CPP_VER
ENV AWS_SDK_CPP_VER ${AWS_SDK_CPP_VER:-1.3.42}
ENV DEBIAN_FRONTEND noninteractive

ENV DEPS \
	build-essential \
	autoconf \
	g++ \
	gcc \
	make \
	apt-utils \
	ca-certificates \
	libssl-dev \
	libcurl4-openssl-dev \
	curl \
	libxml2 \
	vim \
	wget \
	mysql-client \
	xz-utils \
	libc-dev \
	file \
	mlocate \
	unzip \
	libpulse-dev

RUN apt-get update && apt-get install -y $DEPS --no-install-recommends

# Install CMake
RUN mkdir -p /tmp/build
COPY dist/cmake-3.10.2-Linux-x86_64.tar.gz /tmp/build
WORKDIR /tmp/build
RUN tar -v -zxf cmake-3.10.2-Linux-x86_64.tar.gz
WORKDIR /tmp/build/cmake-3.10.2-Linux-x86_64
RUN cp -rp bin/* /usr/local/bin/
RUN cp -rp share/* /usr/local/share/
RUN cp -rp man/* /usr/local/man/
RUN cp -rp doc/* /usr/local/doc/
WORKDIR /
RUN rm -rf /tmp/build

RUN mkdir -p /tmp/build/build
COPY dist/aws-sdk-cpp-${AWS_SDK_CPP_VER}.zip /tmp/build/
WORKDIR /tmp/build
RUN unzip aws-sdk-cpp-${AWS_SDK_CPP_VER}.zip && rm -f aws-sdk-cpp-${AWS_SDK_CPP_VER}.zip
WORKDIR /tmp/build/build
RUN cmake -DCMAKE_BUILD_TYPE=Release ../aws-sdk-cpp-${AWS_SDK_CPP_VER} \
	&& make \
	&& make install \
	&& make clean \
	&& cd /tmp/build \
	&& rm -rf aws-sdk-cpp-${AWS_SDK_CPP_VER} \
	&& rm -rf build
WORKDIR /tmp
RUN rm -rf *
WORKDIR /




