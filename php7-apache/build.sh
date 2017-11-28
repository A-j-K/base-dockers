#!/bin/bash

PHP_VER="7.1.12"

docker build --build-arg PHP_VER=$PHP_VER -t php7-apache:${PHP_VER} .

