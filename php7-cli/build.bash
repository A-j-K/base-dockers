#!/bin/bash

PHP_VER="7.0.9"

docker build --build-arg PHP_VER=$PHP_VER -t php7-cli:${PHP_VER}.1 .

