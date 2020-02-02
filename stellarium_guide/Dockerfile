FROM ubuntu:18.04 
MAINTAINER Andy Kirkham

ENV PKGS \
	texlive-base \
	texlive-bibtex-extra \
	texlive-latex-recommended \
	texlive-latex-extra\
	texlive-pictures \
	texlive-fonts-recommended \
	biber \
	make \
	git \
	ssh \
	curl \
	unzip \
	cmake \
	autoconf \
	apt-utils \
	vim \
	file \
	wget 

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* 

WORKDIR /root

