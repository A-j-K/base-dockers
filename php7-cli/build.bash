#!/bin/bash

PHP_VER="7.2.1"

docker build --build-arg PHP_VER=$PHP_VER -t php7-cli:${PHP_VER} .

