#!/bin/bash
#
# TAG_VER:
#
# 1. Initial image
# 2. Add Google Protobuf pecl module
# 3.
# 4. Updated PHP to 7.2.6
#    Update Zookeeper, 3.4.11 vanished!
# 5. Updated PHP to 7.3.9
#    Updated to buster-slim
#    Updated to libcurl4
#    Used default-mysql-client
#    7.3.x threw up compile issues that had to be removed from the build.
#

set -e

TAG_VER="4"

if [[ -z $1 || -z $2 || -z $3 ]]; then
	PHP_VER_MAJOR="7"
	PHP_VER_MINOR="3"
	PHP_VER_PATCH="9"
else
	PHP_VER_MAJOR=$1
	PHP_VER_MINOR=$2
	PHP_VER_PATCH=$3
fi
PHP_VER="${PHP_VER_MAJOR}.${PHP_VER_MINOR}.${PHP_VER_PATCH}"
IMAGE="php-${PHP_VER_MAJOR}-${PHP_VER_MINOR}-${PHP_VER_PATCH}-${TAG_VER}-cli"
REPO="andykirkham/php-cli"

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


