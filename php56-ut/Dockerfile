FROM php:5.6
MAINTAINER Andy Kirkham

WORKDIR /tmp
ENV PKGS \
	git \
	ssh \
	curl \
	unzip \
	jq \
	awscli \
	cmake \
	autoconf \
	apt-utils \
	vim \
	wget 

WORKDIR /tmp
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get clean \
	&& mkdir -p /workspace
WORKDIR /root

