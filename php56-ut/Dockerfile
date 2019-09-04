FROM php:5.6
MAINTAINER Andy Kirkham

WORKDIR /tmp
ENV PKGS \
	git \
	ssh \
	curl \
	unzip \
	jq \
	awscli \
	cmake \
	autoconf \
	apt-utils \
	vim \
	wget 

WORKDIR /tmp
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get clean \
	&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& chmod 755 composer.phar \
	&& mv composer.phar /usr/local/bin/composer \
	&& mkdir -p /workspace
WORKDIR /root

