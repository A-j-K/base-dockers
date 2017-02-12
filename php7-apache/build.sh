#!/bin/bash

PHP_VER="7.1.1"

docker build --build-arg PHP_VER=$PHP_VER -t php7-apache:${PHP_VER} .

