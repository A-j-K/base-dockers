#!/bin/bash
#
# TAG_VER:
#
# 1. Initial image

set -e

TAG_VER="1"

if [[ -z $1 || -z $2 || -z $3 ]]; then
	PHP_VER_MAJOR="5"
	PHP_VER_MINOR="6"
	PHP_VER_PATCH="40"
else
	PHP_VER_MAJOR=$1
	PHP_VER_MINOR=$2
	PHP_VER_PATCH=$3
fi
PHP_VER="${PHP_VER_MAJOR}.${PHP_VER_MINOR}.${PHP_VER_PATCH}"
IMAGE="php-${PHP_VER_MAJOR}-${PHP_VER_MINOR}-${PHP_VER_PATCH}-${TAG_VER}-cli"
REPO="andykirkham/php5-cli"

echo "Building image ${IMAGE}:${PHP_VER}-${TAG_VER}"

docker build \
	--build-arg PHP_VER=$PHP_VER \
	--build-arg TAG_VER=$TAG_VER \
	-t ${IMAGE}:${PHP_VER}-${TAG_VER} \
	.

echo "Push container to Docker Hub thus:"
echo "  docker login"
echo "  docker tag ${IMAGE}:${PHP_VER}-${TAG_VER} ${REPO}:${PHP_VER}-${TAG_VER}"
echo "  docker push ${REPO}:${PHP_VER}-${TAG_VER}"


