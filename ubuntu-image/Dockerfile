FROM ubuntu:17.04
MAINTAINER Andy Kirkham

# Command And Control node base definition

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common
RUN DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:ansible/ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get update

ENV PKGS \
	ansible \
	git \
	subversion \
	curl \
	unzip \
	jq \
	awscli \
	openjdk-8-jdk \
	python-pip \
	cmake \
	autoconf \
	apt-utils \
	vim \
	file \
	wget \
	gpg \
	qt4-default \
	libapr1-dev \
	libsvn-dev \
	libsvncpp-dev \
	libsvncpp3 libsvn1

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4_2.9-1_amd64.deb > libjansson4_2.9-1_amd64.deb \
        && dpkg -i libjansson4_2.9-1_amd64.deb \
        && rm -f libjansson4_2.9-1_amd64.deb
RUN curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson-dev_2.9-1_amd64.deb > libjansson-dev_2.9-1_amd64.deb \
        && dpkg -i libjansson-dev_2.9-1_amd64.deb \
        && rm -f libjansson-dev_2.9-1_amd64.deb
RUN curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4-dbgsym_2.9-1_amd64.ddeb > libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && dpkg -i libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && rm -f libjansson4-dbgsym_2.9-1_amd64.ddeb

RUN apt-get clean

RUN mkdir -p /workspace
WORKDIR /workspace

