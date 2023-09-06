#!/bin/bash

# Build Command And Control base image
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t cac-terraform:0.13.6 .

