#!/bin/bash
#
# TAG_VER:
#
# 1. Initial image
#

TAG_VER="x"
PHP_VER="7.2.2"

docker build \
	--build-arg PHP_VER=$PHP_VER \
	--build-arg TAG_VER=$TAG_VER \
	-t php7-cli:${PHP_VER}-${TAG_VER} \
	.

echo "Push container to Docker Hub thus:"
echo "  docker login"
echo "  docker tag php7-cli:${PHP_VER}-${TAG_VER} andykirkham/php7-cli-developer:${PHP_VER}-${TAG_VER}"
echo "  docker push andykirkham/php7-cli-developer:${PHP_VER}-${TAG_VER}"


