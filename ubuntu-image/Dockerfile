FROM ubuntu:16.04
MAINTAINER Andy Kirkham

# Command And Control node base definition

WORKDIR /tmp
ENV PKGS \
	ansible \
	git \
	ssh \
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
	qt4-default \
	libapr1-dev \
	libsvn-dev \
	libsvncpp-dev \
	libsvncpp3 libsvn1

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common \
	&& DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:ansible/ansible \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4_2.9-1_amd64.deb > libjansson4_2.9-1_amd64.deb \
        && DEBIAN_FRONTEND=noninteractive dpkg -i libjansson4_2.9-1_amd64.deb \
        && rm -f libjansson4_2.9-1_amd64.deb \
	&& curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson-dev_2.9-1_amd64.deb > libjansson-dev_2.9-1_amd64.deb \
        && DEBIAN_FRONTEND=noninteractive dpkg -i libjansson-dev_2.9-1_amd64.deb \
        && rm -f libjansson-dev_2.9-1_amd64.deb \
	&& curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4-dbgsym_2.9-1_amd64.ddeb > libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && DEBIAN_FRONTEND=noninteractive dpkg -i libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && rm -f libjansson4-dbgsym_2.9-1_amd64.ddeb \
	&& DEBIAN_FRONTEND=noninteractive apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /workspace
WORKDIR /workspace

