FROM andykirkham/aws-sdk-cpp:1.3.43
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ARG PROXYGEN_VER
ENV PROXYGEN_VER ${PROXYGEN_VER:-2018.01.22.00}

RUN apt-get update && apt-get install -y autoconf-archive automake

WORKDIR /tmp
RUN curl -sSL https://github.com/facebook/proxygen/archive/v${PROXYGEN_VER}.zip > proxygen.zip \
	&& unzip proxygen.zip \
	&& rm -f proxygen.zip 
WORKDIR /tmp/proxygen-${PROXYGEN_VER}/proxygen
RUN ./deps.sh 
RUN ./reinstall.sh 
RUN cd /tmp && rm -rf proxygen-${PROXYGEN_VER}

