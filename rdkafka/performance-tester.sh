#!/bin/bash

FROM=${FROM:-"end"}
TOPIC=${TOPIC:-"test"}
GROUP=${GROUP:="rdkafkatestconsumer"}
BROKER=${BROKER:-""}
SASL_USER=${SASL_USER:-""}
SASL_PASS=${SASL_PASS:-""}
MECHANISM=${MECHANISM:-""}
PARTITION=${PARTITION:-"0"}
SECURITY_PROTOCOL=${SECURITY_PROTOCOL:=""}
MESSAGE_COUNT=${MESSAGE_COUNT:=""}
MESSAGE_SIZE=${MESSAGE_SIZE:=""}
MESSAGE_RATE=${MESSAGE_RATE:=$MESSAGE_COUNT}

_terminate() {
	echo "Caught SIGTERM signal"
	CHILDREN=`ps auwx | grep "rdkafka -C -t" | grep -v "grep rdkafka" | awk '{ printf "%d ", $2 }'`
	for pid in $CHILDREN; do
		echo "Killing rdkafka $pid"
		kill -TERM "$pid"
		wait "$pid"
	done
	exit 0
}

trap _terminate SIGTERM

# Start up a consumer so that rdkafka_performance can measure latency as well 
rdkafka_performance -C \
    -l \
    -t $t \
    -p $PARTITION \
    -b $BROKER \
    -o $FROM \
    -X "group.id=$GROUP" \
    -X "sasl.mechanisms=$MECHANISM" \
    -X "security.protocol=$SECURITY_PROTOCOL" \
    -X "sasl.username=$SASL_USER" \
    -X "sasl.password=$SASL_PASS" \
    -X "socket.timeout.ms=30000" \
    -X "socket.keepalive.enable=true" \
    -X "log.connection.close=false" \
    -X "reconnect.backoff.jitter.ms=10000" \
    &


# Start performance client with specified settings
# "receive.message.max.bytes=200000000"
rdkafka_performance -P \
    -t $t \
    -c $MESSAGE_COUNT \
    -s $MESSAGE_SIZE \
    -l \
    -o $FROM \
    -r $MESSAGE_RATE \
    -b $BROKER \
    -X "group.id=$GROUP" \
    -X "sasl.mechanisms=$MECHANISM" \
    -X "security.protocol=$SECURITY_PROTOCOL" \
    -X "sasl.username=$SASL_USER" \
    -X "sasl.password=$SASL_PASS" \
    -X "socket.timeout.ms=30000" \
    -X "socket.keepalive.enable=true" \
    -X "log.connection.close=false" \
    -X "reconnect.backoff.jitter.ms=10000"

