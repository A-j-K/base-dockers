#!/bin/bash

FROM=${FROM:-"end"}
TOPIC=${TPOIC:-"test"}
GROUP=${GROUP:="rdkafkatestconsumer"}
BROKER=${BROKER:-""}
SASL_USER=${SASL_USER:-""}
SASL_PASS=${SASL_PASS:-""}
MECHANISM=${MECHANISM:-""}
PARTITION=${PARTITION:-"0"}
SECURITY_PROTOCOL=${SECURITY_PROTOCOL:=""}

if [[ ! -z $MECHANISM ]]; then
	rdkafka -C \
		-t $TOPIC \
		-p $PARTITION \
		-b $BROKER \
		-o $FROM \
		-X "group.id=$GROUP" \
		-X "sasl.mechanisms=$MECHANISM" \
		-X "security.protocol=$SECURITY_PROTOCOL" \
		-X "sasl.username=$SASL_USER" \
		-X "sasl.password=$SASL_PASS" 
else
	rdkafka -C \
		-t $TOPIC \
		-p $PARTITION \
		-b $BROKER \
		-o $FROM \
		-X "group.id=$GROUP" 
fi

