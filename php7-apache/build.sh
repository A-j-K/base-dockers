#!/bin/bash

PHP_VER="7.0.9"

docker build --build-arg PHP_VER=$PHP_VER -t php7-apache:${PHP_VER}.1 .

