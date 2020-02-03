FROM ubuntu:18.04 
MAINTAINER Andy Kirkham

ENV PDFTK_VER v3.0.9

ENV PKGS \
	texlive-base \
	texlive-bibtex-extra \
	texlive-latex-recommended \
	texlive-latex-extra\
	texlive-pictures \
	texlive-fonts-recommended \
	biber \
	build-essential \
	cmake \
	zlib1g-dev \
	libgl1-mesa-dev \
	gcc \
	g++ \
      	graphviz \
	doxygen \
	gettext \
	git \
      	qtscript5-dev \
	libqt5svg5-dev \
	qttools5-dev-tools \
	qttools5-dev \
      	libqt5opengl5-dev \
	qtmultimedia5-dev \
	libqt5multimedia5-plugins \
      	libqt5serialport5 \
	libqt5serialport5-dev \
	qtpositioning5-dev \
	libgps-dev \
      	libqt5positioning5 \
	libqt5positioning5-plugins \
	qt5-default \
	libgps-dev \
	libqt5positioning5 \
	make \
	git \
	ssh \
	curl \
	unzip \
	autoconf \
	apt-utils \
	vim \
	file \
	wget \
	ghostscript \
	default-jdk-headless \
	default-jre-headless \
	ant \
	libcommons-lang3-java \
	libbcprov-java

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common \
	&& DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:malteworld/ppa \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS pdftk --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& ln -s /usr/bin/pdftk /usr/bin/pdftk.exe \
	&& ln -s /usr/bin/ghostscript /usr/bin/gswin64c.exe

WORKDIR /root

