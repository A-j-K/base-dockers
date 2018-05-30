#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build \
	--build-arg MAKE_USER=${USER} \
	--build-arg USER_UID=${UID} \
	-t ca-signer-platform-kafka:latest \
	${SCRIPTDIR}

