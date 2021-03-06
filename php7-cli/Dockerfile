FROM debian:bullseye-slim
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ARG PHP_VER
ARG TAG_VER
ENV	PHP_RDKAFKA_VER="4.1.1" \
	PHP_ZOOKEEPER_VER="0.6.4" \
	LIB_ZOOKEEPER_VER="3.4.14" \
	PHP_MEMCACHED_VER="3.1.5" \
	LIB_JANSSON_VER="2.13.1" \
	PROTOBUF_VER="4.0.0-rc2" \
	PECL_FILE_FORMATS_YAML_VER="2.2.0" \
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
	git \
	curl \
	libonig-dev \
	libsqlite3-dev \
	ca-certificates \
	libargon2-0-dev \
	libc-dev \
	libffi-dev \
	libssl-dev \
	libxslt1-dev \
	libxml2 \
	libxml2-dev \
	libcurl4 \
	libedit2 \
	libsqlite3-0 \
	default-libmysqlclient-dev \
	libbison-dev \
	libcurl4-gnutls-dev \
	libedit-dev \
	libev-dev \
	libgd-dev \
	libjpeg-dev \
	libpng-dev \
	libzip-dev \
	zlib1g-dev \
	libsodium-dev \
	libmbedtls-dev 

ENV DEPS_TESTING \
	sqlite3

ENV DEPS_TOOLS \
	default-mysql-client \
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

ENV CFLAGS="${CFLAGS} -Wno-deprecated-declarations"

RUN	echo 'Package: php*' > /etc/apt/preferences.d/no-debian-php \
	&& echo 'Pin: release *' >> /etc/apt/preferences.d/no-debian-php \
	&& echo 'Pin-Priority: -1' >> /etc/apt/preferences.d/no-debian-php \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		$DEPS $DEPS_TEMP $DEPS_TOOLS --no-install-recommends \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& mkdir -p /tmp/build \
	&& curl -sSL https://github.com/php/php-src/archive/php-$PHP_VER.zip > /tmp/build/php-$PHP_VER.zip \
	&& cd /tmp/build && unzip -q php-$PHP_VER.zip \
	&& rm -f php-$PHP_VER.zip \
	&& cd /tmp/build/php-src-php-$PHP_VER \
	&& mkdir -p $PHP_INI_DIR/conf.d \
	&& ./buildconf --force \
	&& ./configure --help \
	&& gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
	   debMultiarch="$(dpkg-architecture --query DEB_BUILD_MULTIARCH)"; \ 
	  ./configure \
		--build="$gnuArch" \
		--with-config-file-path="$PHP_INI_DIR" \
		--with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
		--disable-cgi \
		--enable-embed=static \
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
		--with-sodium \
		--with-password-argon2 \
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
	&& echo "Installing Ninja" \
	&& mkdir -p /tmp/build \
	&& cd /tmp/build \
	&& curl -sSL https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-linux.zip > ninja-linux.zip \
	&& unzip ninja-linux.zip \
	&& cp ninja /usr/local/bin/ninja \
	&& cd / \
	&& rm -rf /tmp/build \
# CMake
	&& echo "Installing Cmake" \
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
	&& echo "Installing Libevent" \
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
	&& echo "Installing ZMQ" \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y libzmq3-dev \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/mkoppanen/php-zmq/archive/master.zip > zmq.zip \
	&& unzip zmq.zip && rm -f zmq.zip \
	&& cd php-zmq-master \
	&& phpize && ./configure && make && make install \
	&& echo "extension=zmq.so" > $PHP_INI_DIR/conf.d/99-zeromq.ini \
	&& cd / && rm -rf /tmp/build \
# Nanomsg
# Drop for now, doesn't compile on buster-slim
#	&& echo "Installing Nanomsg" \
#	&& DEBIAN_FRONTEND=noninteractive apt-get install -y libnanomsg-dev libnanomsg5 \
#	&& mkdir -p /tmp/build && cd /tmp/build \
#	&& curl -sSL https://github.com/mkoppanen/php-nano/archive/master.zip > nanomsg.zip \
#	&& unzip nanomsg.zip && rm -f nanmsg.zip \
#	&& cd php-nano-master \
#	&& phpize && ./configure && make && make install \
#	&& echo "extension=nano.so" > $PHP_INI_DIR/conf.d/99-nanomsg.ini \
#	&& cd / && rm -rf /tmp/build \
# AMQP
	&& echo "Installing AMQP" \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y librabbitmq-dev \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/pdezwart/php-amqp/archive/master.zip > amqp.zip \
	&& unzip amqp.zip && rm -f amqp.zip \
	&& cd php-amqp-master \
	&& phpize && ./configure && make && make install \
	&& echo "extension=amqp.so" > $PHP_INI_DIR/conf.d/99-amqp.ini \
	&& cd / && rm -rf /tmp/build \
# Yaml
	&& echo "Installing YAML" \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y libyaml-dev \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/php/pecl-file_formats-yaml/archive/${PECL_FILE_FORMATS_YAML_VER}.zip > yaml.zip \
	&& unzip yaml.zip && rm -f yaml.zip \
	&& cd pecl-file_formats-yaml-${PECL_FILE_FORMATS_YAML_VER} \
	&& phpize && ./configure && make && make install \
	&& echo "extension=yaml.so" > $PHP_INI_DIR/conf.d/99-yaml.ini \
	&& cd / && rm -rf /tmp/build \
# Memcache
	&& echo "Installing Memcache" \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y libmemcached-dev \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL http://pecl.php.net/get/memcached-${PHP_MEMCACHED_VER}.tgz > memcached.tgz \
	&& tar -zxf memcached.tgz && rm -f memcached.tgz \
	&& cd memcached-${PHP_MEMCACHED_VER} \
	&& phpize && ./configure && make && make install \
	&& echo "extension=memcached.so" > $PHP_INI_DIR/conf.d/99-memcached.ini \
	&& cd / && rm -rf /tmp/build \
# Zookeeper
# The zookeeper c client is broken on compile, remove it.
#	&& echo "Installing Zookeeper" \
#	&& mkdir -p /tmp/build && cd /tmp/build \
#	&& curl -sSL http://mirrorservice.org/sites/ftp.apache.org/zookeeper/zookeeper-${LIB_ZOOKEEPER_VER}/zookeeper-${LIB_ZOOKEEPER_VER}.tar.gz > zookeeper.tgz \
#	&& tar -zxf zookeeper.tgz && rm -f zookeeper.tgz \
#	&& cd zookeeper-${LIB_ZOOKEEPER_VER} && cd zookeeper-client/zookeeper-client-c \
#	&& ./configure --prefix=/usr/ && make && make install \
#	&& cd / && rm -rf /tmp/build \
#	&& mkdir -p /tmp/build && cd /tmp/build \
#	&& curl -sSL http://pecl.php.net/get/zookeeper-${PHP_ZOOKEEPER_VER}.tgz > php-zookeeper.tgz \
#	&& tar -zxf php-zookeeper.tgz && rm -f php-zookeeper.tgz \
#	&& cd zookeeper-${PHP_ZOOKEEPER_VER} \
#	&& phpize && ./configure && make && make install \
#	&& echo "extension=zookeeper.so" > $PHP_INI_DIR/conf.d/20-zookeeper.ini \
#	&& cd / && rm -rf /tmp/build \
# RdKafka
	&& echo "Installing RdKafka" \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/edenhill/librdkafka/archive/v1.5.3.zip > librdkafka.zip \
	&& unzip librdkafka.zip && rm -f librdkafka.zip \
	&& cd librdkafka-1.5.3 \
	&& ./configure && make && make install \
	&& cd .. && rm -rf librdkafka-1.5.3 \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL http://pecl.php.net/get/rdkafka-${PHP_RDKAFKA_VER}.tgz > rdkafka.tgz \
	&& tar -zxf rdkafka.tgz && rm -f rdkafka.tgz \
	&& cd rdkafka-${PHP_RDKAFKA_VER} \
	&& phpize && ./configure && make && make install \
	&& echo "extension=rdkafka.so" > $PHP_INI_DIR/conf.d/30-rdkafka.ini \
	&& cd / && rm -rf /tmp/build && rm -rf /tmp/dist \
# Jansson
	&& echo "Installing Jannson" \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/akheron/jansson/archive/v$LIB_JANSSON_VER.zip > jansson-$LIB_JANSSON_VER.zip \
	&& unzip jansson-$LIB_JANSSON_VER.zip && rm -f jansson-$LIB_JANSSON_VER.zip \
	&& cd jansson-$LIB_JANSSON_VER \
	&& mkdir tmpbuild && cd tmpbuild \
	&& cmake .. && make && make install \
	&& cd / && rm -rf /tmp/build \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/stellartech/phpjansson/archive/master.zip > php_jansson.zip \
	&& unzip php_jansson.zip && rm -f php_jansson.zip \
	&& cd phpjansson-master \
	&& phpize && ./configure && make && make install \	
	&& echo "extension=jansson.so" > $PHP_INI_DIR/conf.d/99-jansson.ini \
	&& cd / && rm -rf /tmp/build \
# Google Protobuf
#	&& echo "Installing Gogle Protobuf" \
#	&& mkdir -p /tmp/build \
#	&& cd /tmp/build \
#	&& curl -OL https://github.com/google/protobuf/releases/download/v${PROTOBUF_VER}/protobuf-php-${PROTOBUF_VER}.tar.gz \
#	&& tar -zxf protobuf-php-${PROTOBUF_VER}.tar.gz && rm -f protobuf-php-${PROTOBUF_VER}.tar.gz \
#	&& cd protobuf-${PROTOBUF_VER} \
#	&& DIST_LANG=php ./configure && DIST_LANG=php make -j 4 && DIST_LANG=php make install \
#	&& cd php/ext/google/protobuf \
#	&& phpize && ./configure && DIST_LANG=php make && DIST_LANG=php make install \
#	&& echo "extension=protobuf.so" > $PHP_INI_DIR/conf.d/99-protobuf.ini \
#	&& cd / && rm -rf /tmp/build \
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

