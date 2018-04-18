FROM debian:stretch-slim
MAINTAINER Andy Kirkham

ARG VERSION

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
	bash \
	libc-dev \
	ca-certificates \
	libzip-dev \
	zlib1g-dev \
	libcurl4-gnutls-dev \
	libssl-dev \
	curl \
	unzip

ENV DEPS_TOOLS \
	apt-utils \
	pkg-config \
	vim \
	ssh \
	xz-utils 
	
COPY consumer.sh /usr/local/bin/consumer.sh

RUN	DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
		$DEPS $DEPS_TEMP $DEPS_TOOLS --no-install-recommends \
	&& mkdir -p /tmp/build && cd /tmp/build \
	&& curl -sSL https://github.com/edenhill/librdkafka/archive/v${VERSION}.zip > librdkafka.zip \
	&& unzip librdkafka.zip && rm -f librdkafka.zip \
	&& cd librdkafka-${VERSION} \
	&& ./configure --prefix=/usr/local && make all install \
	&& cp examples/rdkafka_consumer_example /usr/local/bin/rdkafka_consumer \
	&& cp examples/rdkafka_example  /usr/local/bin/rdkafka \
	&& cp examples/rdkafka_simple_producer /usr/local/bin/rdkafka_producer \
	&& cp examples/rdkafka_performance /usr/local/bin/rdkafka_performance \
	&& cp examples/kafkatest_verifiable_client /usr/local/bin/kafkatest_verifiable_client \
	&& cd /tmp && rm -rf build \
	&& DEBIAN_FRONTEND=noninteractive apt-get remove -y $DEPS_TEMP $DEPS_TOOLS \
	&& DEBIAN_FRONTEND=noninteractive apt -y autoremove \
	&& rm -r /var/lib/apt/lists/*
CMD ["/usr/local/bin/consumer.sh"]
