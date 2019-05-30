FROM ubuntu:18.04
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ENV DEBIAN_FRONTEND noninteractive

ENV EXAKAT_VER "1.7.3"
ENV TINKERPOP_VER "3.3.3"

ENV DEPS_BASE \
	apt-utils \
	software-properties-common \
	language-pack-en-base \
	apt-transport-https \
	lsb-release \
	ca-certificates \
	curl \
	wget \
	vim \
	git \
	unzip \
	lsof \
	openjdk-8-jre \
	openjdk-8-jdk-headless
	
ENV DEPS_ONDREJ \
	php5.6 \
	php5.6-mbstring \
	php5.6-curl \
	php5.6-sqlite3 \
	php7.1 \
	php7.1-mbstring \
	php7.1-curl \
	php7.1-sqlite3 \
	php7.2 \
	php7.2-mbstring \
	php7.2-curl \
	php7.2-sqlite3

# Switching PHP versions:
# update-alternatives --config php
# update-alternatives --set php /usr/bin/php5.6

COPY src/exakat.ini /exakat/config/exakat.ini

RUN	apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $DEPS_BASE --no-install-recommends \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& export LC_ALL=en_US.UTF-8 \
	&& export LANG=en_US.UTF-8 \
	&& DEBIAN_FRONTEND=noninteractive LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $DEPS_ONDREJ \
	&& cd /exakat \
	&& curl -o apache-tinkerpop-gremlin-server-bin.zip http://dist.exakat.io/apache-tinkerpop-gremlin-server-${TINKERPOP_VER}-bin.zip \
	&& unzip -q apache-tinkerpop-gremlin-server-bin.zip \
	&& rm -rf apache-tinkerpop-gremlin-server-bin.zip \
	&& mv apache-tinkerpop-gremlin-server-${TINKERPOP_VER} tinkergraph \
	&& cd tinkergraph \
	&& ./bin/gremlin-server.sh -i org.apache.tinkerpop neo4j-gremlin ${TINKERPOP_VER} \
	&& cd /exakat \ 
	&& curl -o exakat.phar http://dist.exakat.io/index.php?file=exakat-${EXAKAT_VER}.phar \
	&& php exakat.phar doctor

WORKDIR /exakat

