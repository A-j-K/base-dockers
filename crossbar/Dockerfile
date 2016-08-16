FROM andykirkham/base-docker-php7-cli:latest
MAINTAINER Andy Kirkham <andy@spiders-lair.com>

ENV DEBIAN_FRONTEND noninteractive

ENV DEPS \
	build-essential \
	python2.7 \
        python2.7-dev \
        python-setuptools \
        python-pip 

RUN apt-get update && apt-get install -y $DEPS --no-install-recommends

RUN pip install virtualenv \
	&& mkdir -p /var/www/html/crossbar \
	&& cd /var/www/html/crossbar \
	&& virtualenv python-venv \
	&& cd /var/www/html/crossbar/python-venv \
	&& . bin/activate && pip install crossbar \
	&& cd / \
	&& apt-get remove -y build-essential \
	&& apt-get autoremove -y \
	&& rm -r /var/lib/apt/lists/*

