FROM ubuntu:16.04
MAINTAINER Andy Kirkham

# Command And Control node base definition

#RUN DEBIAN_FRONTEND=noninteractive apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common
#RUN DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:ansible/ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

#E: Package 'libmysqlclient18' has no installation candidate
#E: Unable to locate package librabbitmq1

ENV PKGS \
	build-essential \
	autoconf \
	g++ \
	gcc \
	make \
	bison \
	re2c \
	apt-utils \
	ca-certificates \
	file \
	libc-dev \
	pkg-config \
	libffi-dev \
	libssl-dev \
	libxslt1-dev \
	libxml2 \
	libxml2-dev \
	curl \
	libcurl3 \
	libedit2 \
	libsqlite3-0 \
	libxml2 \
	xz-utils \
	vim \
	mlocate \
	wget \
	unzip \
	libmysqlclient-dev \
	mysql-client \
	libbison-dev \
	libcurl4-gnutls-dev \
	libedit-dev \
	libevent-dev \
	libzmq3-dev \
	libnanomsg-dev \
	libmemcached-dev \
	libev-dev \
	librabbitmq-dev \
	git

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends

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

RUN mkdir -p /workspace
WORKDIR /workspace

