FROM andykirkham/aws-sdk-cpp:1.3.43
MAINTAINER Andy Kirkham <andy@spiders-lair.com>
ARG PROXYGEN_VER
COPY mydeps.sh /mydeps.sh
RUN 	apt-get update \
	&& apt-get install -y sudo autoconf-archive automake \
	&& cd /tmp \
	&& curl -sSL https://github.com/facebook/proxygen/archive/v${PROXYGEN_VER}.zip > proxygen.zip \
	&& unzip proxygen.zip \
	&& rm -f proxygen.zip \
	&& cd /tmp/proxygen-${PROXYGEN_VER}/proxygen \
	&& cp /mydeps.sh mydeps.sh \
	&& ./mydeps.sh \
	&& cd /tmp \
	&& rm -rf proxygen-${PROXYGEN_VER} \
	&& apt-get clean

