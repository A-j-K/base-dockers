#!/bin/bash

docker run --name SELF -p 8000:80 -p 8443:443 -d self-signed-test

