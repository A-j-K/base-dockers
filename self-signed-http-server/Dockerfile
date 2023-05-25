FROM php7

WORKDIR /tmp
ENV PKGS \
	git \
	ssh \
	curl

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* 

RUN mkdir -p /tmp/github && mkdir -p /tmp/scripts
RUN cd /tmp/github \
	&& git clone https://github.com/warmcat/libwebsockets.git


