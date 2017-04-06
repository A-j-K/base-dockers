FROM debian:jessie
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ARG PHP_VER="7.1.3"

ENV DEBIAN_FRONTEND noninteractive

ENV DEPS_TEMP \
	build-essential \
	autoconf \
	g++ \
	gcc \
	make \
	bison \
	re2c 

ENV DEPS \
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
	libmysqlclient18 \
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
	librabbitmq1 \
	git

RUN apt-get update && apt-get install -y $DEPS $DEPS_TEMP --no-install-recommends

RUN mkdir -p /tmp/build

RUN curl -sSL https://github.com/php/php-src/archive/php-$PHP_VER.zip > /tmp/build/php-$PHP_VER.zip

ENV PHP_INI_DIR /usr/local/etc/php

RUN cd /tmp/build && unzip -q php-$PHP_VER.zip \
	&& rm -f php-$PHP_VER.zip \
	&& cd /tmp/build/php-src-php-$PHP_VER \
	&& mkdir -p $PHP_INI_DIR/conf.d \
	&& ./buildconf --force \
	&& ./configure \
		--with-config-file-path="$PHP_INI_DIR" \
		--with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
		--disable-cgi \
		--enable-mysqlnd \
		--with-pdo-mysql \
		--enable-mbstring \
		--with-curl \
		--with-libedit \
		--with-openssl \
		--enable-bcmath \
		--enable-pcntl \
		--with-zlib \
		--without-pear \
	&& make -j"$(nproc)" \
	&& make install \
	&& { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
	&& make clean \
	&& cd / \
	&& rm -rf /tmp/build

RUN mkdir -p /tmp/build
COPY dist/cmake-3.8.0-rc1-Linux-x86_64.tar.gz /tmp/build
WORKDIR /tmp/build
RUN tar -v -zxf cmake-3.8.0-rc1-Linux-x86_64.tar.gz 
WORKDIR /tmp/build/cmake-3.8.0-rc1-Linux-x86_64
RUN cp -rp bin/* /usr/local/bin/
RUN cp -rp share/* /usr/local/share/
RUN cp -rp man/* /usr/local/man/
RUN cp -rp doc/* /usr/local/doc/
WORKDIR /
RUN rm -rf /tmp/build

RUN mkdir -p /tmp/build
COPY dist/pecl-event-libevent.zip /tmp/build
WORKDIR /tmp/build
RUN unzip pecl-event-libevent.zip && rm pecl-event-libevent.zip
WORKDIR /tmp/build/pecl-event-libevent-master
RUN phpize && ./configure && make && make install
RUN echo "extension=libevent.so" > $PHP_INI_DIR/conf.d/98-libevent.ini
WORKDIR /
RUN rm -rf /tmp/build

RUN mkdir -p /tmp/build
COPY dist/pecl-zeromq.zip /tmp/build
WORKDIR /tmp/build
RUN unzip pecl-zeromq.zip && rm pecl-zeromq.zip
WORKDIR /tmp/build/php-zmq-master
RUN phpize && ./configure && make && make install
RUN echo "extension=zmq.so" > $PHP_INI_DIR/conf.d/99-zeromq.ini
WORKDIR /
RUN rm -rf /tmp/build

RUN mkdir -p /tmp/build
COPY dist/pecl-nanomsg.tgz /tmp/build/pecl-nanomsg.tgz
WORKDIR /tmp/build
RUN tar -v -zxf pecl-nanomsg.tgz && rm pecl-nanomsg.tgz
WORKDIR /tmp/build/php-nano-master
RUN phpize && ./configure && make && make install
RUN echo "extension=nano.so" > $PHP_INI_DIR/conf.d/99-nanomsg.ini
WORKDIR /
RUN rm -rf /tmp/build

RUN mkdir -p /tmp/build
COPY dist/pecl-php-amqp.zip /tmp/build/pecl-php-amqp.zip
WORKDIR /tmp/build
RUN unzip pecl-php-amqp.zip && rm pecl-php-amqp.zip
WORKDIR /tmp/build/php-amqp-1.7.1
RUN phpize && ./configure && make && make install
RUN echo "extension=amqp.so" > $PHP_INI_DIR/conf.d/99-amqp.ini
WORKDIR /
RUN rm -rf /tmp/build

RUN mkdir -p /tmp/build
COPY dist/pecl-memcached.zip /tmp/build/pecl-memcached.zip
WORKDIR /tmp/build
RUN unzip pecl-memcached.zip && rm pecl-memcached.zip
WORKDIR /tmp/build/php-memcached-php7
RUN phpize && ./configure && make && make install
RUN echo "extension=memcached.so" > $PHP_INI_DIR/conf.d/99-memcached.ini
WORKDIR /
RUN rm -rf /tmp/build

RUN mkdir -p /tmp/build
COPY dist/yaf-3.0.3.zip /tmp/build/yaf-3.0.3.zip
WORKDIR /tmp/build
RUN unzip -q yaf-3.0.3.zip && rm yaf-3.0.3.zip
WORKDIR /tmp/build/yaf-yaf-3.0.3
RUN phpize && ./configure && make && make install
RUN echo "extension=yaf.so" > $PHP_INI_DIR/conf.d/99-yaf.ini
WORKDIR /
RUN rm -rf /tmp/build

RUN echo "zend_extension=opcache.so" > $PHP_INI_DIR/conf.d/01-opcache.ini 

# Clean up.
RUN apt-get remove -y $DEPS_TEMP \
	&& apt-get autoremove -y \
	&& rm -r /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer



