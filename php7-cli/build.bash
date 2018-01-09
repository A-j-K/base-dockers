#!/bin/bash

PHP_VER="7.1.13"

docker build --build-arg PHP_VER=$PHP_VER -t php7-cli:${PHP_VER} .

