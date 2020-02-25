FROM ubuntu:18.04
MAINTAINER Andy Kirkham

ENV WSLAY_VER="1.1.0"
ENV LIBRDKAFKA "1.3.0" 

ENV DEPS \
	software-properties-common \
	build-essential \
        autoconf \
        g++ \
        gcc \
        make \
        bison \
        re2c \
        python \
        cmake \
	bash \
	libc-dev \
	libsasl2-dev \
	ca-certificates \
	libzip-dev \
	zlib1g-dev \
	libcurl4-gnutls-dev \
	libssl-dev \
	curl \
	unzip \
	vim \
	procps \
	libevent-2.1-6 \
	libevent-core-2.1-6 \
	libevent-extra-2.1-6 \
	libevent-openssl-2.1-6 \
	libevent-pthreads-2.1-6 \
	libevent-dev \
	libevhtp-dev \
	libnghttp2-dev \
	libcrypto++-dev \
	libjansson-dev \
	libsodium-dev 

ENV DEPS_TOOLS \
	apt-utils \
	pkg-config \
	ssh \
	xz-utils 

RUN	DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		$DEPS $DEPS_TOOLS --no-install-recommends 

RUN	cd /tmp && curl -sSL  https://github.com/tatsuhiro-t/wslay/archive/release-${WSLAY_VER}.zip > temp.zip \
	&& unzip temp.zip && rm -f temp.zip \
	&& cd wslay-release-${WSLAY_VER} && mkdir build && cd build \
	&& cmake -DWSLAY_STATIC=ON .. && make && make install \
	&& cd /tmp && rm -rf wslay-release-${WSLAY_VER} 
WORKDIR /root
	
