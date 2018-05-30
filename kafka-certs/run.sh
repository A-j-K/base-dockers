#!/bin/bash

# Usewd for testing, local dokcer host should have CA Certs

docker run --rm \
	-v /etc/ca-root-crt.pem:/etc/ca-root-crt.pem \
	-v /etc/ca-root-key.pem:/etc/ca-root-key.pem \
	-v `pwd`:/tmp \
	-w /tmp \
	 -it ca-signer-platform-kafka:latest \
	/bin/bash

