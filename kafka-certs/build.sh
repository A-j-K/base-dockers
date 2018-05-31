#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build \
	-t ca-signer-platform-kafka:latest \
	${SCRIPTDIR}

