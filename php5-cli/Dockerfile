FROM php:5.6-cli
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ARG PHP_VER
ARG TAG_VER
ENV	PHP_RDKAFKA_VER="3.0.5" \
	PHP_ZOOKEEPER_VER="0.4.0" \
	LIB_ZOOKEEPER_VER="3.4.11" \
	PHP_MEMCACHED_VER="3.0.4" \
	LIB_JANSSON_VER="2.10" \
	PROTOBUF_VER="3.5.1" \
	PHP_INI_DIR="/usr/local/etc/php" 

ENV DEPS_TEMP \
	build-essential \
	autoconf \
	g++ \
	gcc \
	make \
	bison \
	re2c \
	python \
	cmake

ENV DEPS \
	curl \
	ca-certificates \
	libc-dev \
	libffi-dev \
	libssl-dev \
	libxslt1-dev \
	libxml2 \
	libxml2-dev \
	libcurl3 \
	libedit2 \
	libsqlite3-0 \
	libmysqlclient-dev \
	libmysqlclient18 \
	libbison-dev \
	libcurl4-gnutls-dev \
	libedit-dev \
	libev-dev \
	libgd-dev \
	libjpeg-dev \
	libpng-dev \
	libzip-dev \
	zlib1g-dev 

ENV DEPS_TOOLS \
	mysql-client \
	apt-utils \
	pkg-config \
	mlocate \
	vim \
	ssh \
	wget \
	xz-utils \
	unzip \
	file \
	git

RUN	echo 'Package: php*' > /etc/apt/preferences.d/no-debian-php \
	&& echo 'Pin: release *' >> /etc/apt/preferences.d/no-debian-php \
	&& echo 'Pin-Priority: -1' >> /etc/apt/preferences.d/no-debian-php \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		$DEPS $DEPS_TEMP $DEPS_TOOLS --no-install-recommends \
	&& mkdir -p /tmp/build \
	&& curl -sSL https://github.com/php/php-src/archive/php-$PHP_VER.zip > /tmp/build/php-$PHP_VER.zip \
	&& cd /tmp/build && unzip -q php-$PHP_VER.zip \
	&& rm -f php-$PHP_VER.zip \
	&& cd /tmp/build/php-src-php-$PHP_VER \
	&& mkdir -p $PHP_INI_DIR/conf.d \
	&& ./buildconf --force \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
	   debMultiarch="$(dpkg-architecture --query DEB_BUILD_MULTIARCH)"; \ 
	  ./configure \
		--build="$gnuArch" \
		--with-config-file-path="$PHP_INI_DIR" \
		--with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
		--disable-cgi \
		--enable-embed=shared \
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
		--enable-ftp \
		--enable-exif \
		--enable-zip \
		--with-gd \
		--with-jpeg-dir \
		--with-png-dir \		
		$(test "$gnuArch" = 's390x-linux-gnu' && echo '--without-pcre-jit') \
		--with-libdir="lib/$debMultiarch" \
	&& echo "Compiling PHP silently, please wait..." \
	&& make -s -j"$(nproc)" \
	&& make install \
	&& make clean \
	&& cd / \
	&& rm -rf /tmp/build \
	&& echo -n "${PHP_VER}-${TAG_VER}" > $PHP_INI_DIR/ajk_tag_ver.txt \
# Ninja
	&& mkdir -p /tmp/build \
	&& cd /tmp/build \
	&& curl -sSL https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip > ninja-linux.zip \
	&& unzip ninja-linux.zip \
	&& cp ninja /usr/local/bin/ninja \
	&& cd / \
	&& rm -rf /tmp/build \
# CMake
	&& mkdir -p /tmp/build \
	&& cd /tmp/build \
	&& curl -sSL https://cmake.org/files/v3.10/cmake-3.10.2-Linux-x86_64.tar.gz > cmake.tgz \
	&& tar -zxf cmake.tgz && rm -f cmake.tgz \
	&& cd cmake*/ \
	&& cp -rp bin/* /usr/local/bin/ \
	&& cp -rp share/* /usr/local/share/ \
	&& cp -rp man/* /usr/local/man/ \
	&& cp -rp doc/* /usr/local/doc/ \
	&& cd / \
	&& rm -rf /tmp/build \
# Libevent
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y libevent-dev \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& cd /tmp/build \
	&& curl -sSL https://github.com/expressif/pecl-event-libevent/archive/master.zip > libevent.zip \
	&& unzip libevent.zip && rm -f libevent.zip \
	&& cd pecl-event-libevent-master \
	&& phpize && ./configure && make && make install \
	&& echo "extension=libevent.so" > $PHP_INI_DIR/conf.d/98-libevent.ini \
	&& cd / && rm -rf /tmp/build \
# ZMQ
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y libzmq3-dev \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/mkoppanen/php-zmq/archive/master.zip > zmq.zip \
	&& unzip zmq.zip && rm -f zmq.zip \
	&& cd php-zmq-master \
	&& phpize && ./configure && make && make install \
	&& echo "extension=zmq.so" > $PHP_INI_DIR/conf.d/99-zeromq.ini \
	&& cd / && rm -rf /tmp/build \
# Nanomsg
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y libnanomsg-dev \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/mkoppanen/php-nano/archive/master.zip > nanomsg.zip \
	&& unzip nanomsg.zip && rm -f nanmsg.zip \
	&& cd php-nano-master \
	&& phpize && ./configure && make && make install \
	&& echo "extension=nano.so" > $PHP_INI_DIR/conf.d/99-nanomsg.ini \
	&& cd / && rm -rf /tmp/build \
# AMQP
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y librabbitmq-dev \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/pdezwart/php-amqp/archive/master.zip > amqp.zip \
	&& unzip amqp.zip && rm -f amqp.zip \
	&& cd php-amqp-master \
	&& phpize && ./configure && make && make install \
	&& echo "extension=amqp.so" > $PHP_INI_DIR/conf.d/99-amqp.ini \
	&& cd / && rm -rf /tmp/build \
# Memcache
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y libmemcached-dev \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL http://pecl.php.net/get/memcached-${PHP_MEMCACHED_VER}.tgz > memcached.tgz \
	&& tar -zxf memcached.tgz && rm -f memcached.tgz \
	&& cd memcached-${PHP_MEMCACHED_VER} \
	&& phpize && ./configure && make && make install \
	&& echo "extension=memcached.so" > $PHP_INI_DIR/conf.d/99-memcached.ini \
	&& cd / && rm -rf /tmp/build \
# Zookeeper
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL http://mirrorservice.org/sites/ftp.apache.org/zookeeper/zookeeper-${LIB_ZOOKEEPER_VER}/zookeeper-${LIB_ZOOKEEPER_VER}.tar.gz > zookeeper.tgz \
	&& tar -zxf zookeeper.tgz && rm -f zookeeper.tgz \
	&& cd zookeeper-${LIB_ZOOKEEPER_VER} && cd src/c \
	&& ./configure --prefix=/usr/ && make && make install \
	&& cd / && rm -rf /tmp/build \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL http://pecl.php.net/get/zookeeper-${PHP_ZOOKEEPER_VER}.tgz > php-zookeeper.tgz \
	&& tar -zxf php-zookeeper.tgz && rm -f php-zookeeper.tgz \
	&& cd zookeeper-${PHP_ZOOKEEPER_VER} \
	&& phpize && ./configure && make && make install \
	&& echo "extension=zookeeper.so" > $PHP_INI_DIR/conf.d/20-zookeeper.ini \
	&& cd / && rm -rf /tmp/build \
# RdKafka
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/edenhill/librdkafka/archive/v0.11.3.zip > librdkafka.zip \
	&& unzip librdkafka.zip && rm -f librdkafka.zip \
	&& cd librdkafka-0.11.3 \
	&& ./configure && make && make install \
	&& cd .. && rm -rf librdkafka-0.11.3 \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL http://pecl.php.net/get/rdkafka-${PHP_RDKAFKA_VER}.tgz > rdkafka.tgz \
	&& tar -zxf rdkafka.tgz && rm -f rdkafka.tgz \
	&& cd rdkafka-${PHP_RDKAFKA_VER} \
	&& phpize && ./configure && make && make install \
	&& echo "extension=rdkafka.so" > $PHP_INI_DIR/conf.d/30-rdkafka.ini \
	&& cd / && rm -rf /tmp/build && rm -rf /tmp/dist \
# Enable OPCache
	&& echo "zend_extension=opcache.so" > $PHP_INI_DIR/conf.d/01-opcache.ini \
# Cleanup
	&& { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
	&& DEBIAN_FRONTEND=noninteractive apt-get remove -y $DEPS_TEMP $DEPS_TOOLS \
	&& DEBIAN_FRONTEND=noninteractive apt -y autoremove \
	&& rm -r /var/lib/apt/lists/* \
# Finally, Composer
	&& echo "Installing PHP Composer" \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

