FROM debian:jessie
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ARG PHP_VER="7.0.9"

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
	apache2-bin \
	apache2.2-common

RUN apt-get update && apt-get install -y $DEPS $DEPS_TEMP --no-install-recommends

ENV APACHE_CONF_DIR /etc/apache2
ENV APACHE_ENVVARS $APACHE_CONF_DIR/envvars

RUN set -ex \
	&& . "$APACHE_ENVVARS" \
	&& for dir in \
		"$APACHE_LOCK_DIR" \
		"$APACHE_RUN_DIR" \
		"$APACHE_LOG_DIR" \
		/var/www/html \
	; do \
		rm -rvf "$dir" \
		&& mkdir -p "$dir" \
		&& chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" "$dir"; \
	done

RUN a2dismod mpm_event && a2enmod mpm_prefork

RUN set -ex \
	&& . "$APACHE_ENVVARS" \
	&& ln -sfT /dev/stderr "$APACHE_LOG_DIR/error.log" \
	&& ln -sfT /dev/stdout "$APACHE_LOG_DIR/access.log" \
	&& ln -sfT /dev/stdout "$APACHE_LOG_DIR/other_vhosts_access.log"

RUN { \
		echo '<FilesMatch \.php$>'; \
		echo '\tSetHandler application/x-httpd-php'; \
		echo '</FilesMatch>'; \
		echo; \
		echo 'DirectoryIndex disabled'; \
		echo 'DirectoryIndex index.php index.html'; \
		echo; \
		echo '<Directory /var/www/>'; \
		echo '\tOptions -Indexes'; \
		echo '\tAllowOverride All'; \
		echo '</Directory>'; \
	} | tee "$APACHE_CONFDIR/conf-available/docker-php.conf" \
	&& a2enconf docker-php


ENV PHP_INI_DIR /usr/local/etc/php

RUN mkdir -p /tmp/build \
	&& cd /tmp/build \
	&& curl -sSL https://github.com/php/php-src/archive/php-$PHP_VER.zip > php-$PHP_VER.zip \
	&& unzip php-$PHP_VER.zip \
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
		--with-zlib \
		--with-apxs2 \
	&& make -j"$(nproc)" \
	&& make install \
	&& { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
	&& make clean \
	&& cd / \
	&& rm -rf /tmp/build

RUN mkdir -p /tmp/build
COPY dist/pecl-event-libevent.zip /tmp/build
WORKDIR /tmp/build
RUN unzip pecl-event-libevent.zip && rm pecl-event-libevent.zip
WORKDIR /tmp/build/pecl-event-libevent-master
RUN phpize && ./configure && make && make install
RUN echo "extension=libevent.so" > $PHP_INI_DIR/conf.d/99-libevent.ini
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
COPY dist/pecl-memcached.zip /tmp/build/pecl-memcached.zip
WORKDIR /tmp/build
RUN unzip pecl-memcached.zip && rm pecl-memcached.zip
WORKDIR /tmp/build/php-memcached-php7
RUN phpize && ./configure && make && make install
RUN echo "extension=memcached.so" > $PHP_INI_DIR/conf.d/99-memcached.ini
WORKDIR /
RUN rm -rf /tmp/build

# Clean up.
RUN apt-get remove -y $DEPS_TEMP \
	&& apt-get autoremove -y \
	&& rm -r /var/lib/apt/lists/*



