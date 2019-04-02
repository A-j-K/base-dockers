FROM ubuntu:18.04
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ENV DEBIAN_FRONTEND noninteractive

ENV DEPS \
	apt-utils \
	ca-certificates \
	software-properties-common \
	curl \
	wget \
	mlocate \
	xz-utils \
	unzip \
	vim \
	ssh \
	git \
	screen \
	bzip2 \
	make \
	sudo \
	cmake \
	php

RUN apt-get update \
	&& apt-get install -y $DEPS --no-install-recommends \
	&& apt-get update \
	&& mkdir /exakat && cd exakat \
	&& curl -o exakat.phar http://dist.exakat.io/index.php?file=latest \
	&& curl -o apache-tinkerpop-gremlin-server-3.3.3-bin.zip http://dist.exakat.io/apache-tinkerpop-gremlin-server-3.3.3-bin.zip \
	&& unzip apache-tinkerpop-gremlin-server-3.3.3-bin.zip \
	&& mv apache-tinkerpop-gremlin-server-3.3.3 tinkergraph \
	&& rm -rf apache-tinkerpop-gremlin-server-3.3.3-bin.zip \
	&& cd tinkergraph \
	&& ./bin/gremlin-server.sh -i org.apache.tinkerpop neo4j-gremlin 3.3.3 \
	&& cd ..

WORKDIR /exakat

