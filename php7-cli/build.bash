#!/bin/bash

PHP_VER="7.2.2"

docker build --build-arg PHP_VER=$PHP_VER -t php7-cli:${PHP_VER} .

echo "Push container to Docker Hub thus:"
echo "  docker login"
echo "  docker tag php7-cli:$PHP_VER andykirkham/php7-cli-developer:$PHP_VER"
echo "  docker push andykirkham/php7-cli-developer:$PHP_VER"


