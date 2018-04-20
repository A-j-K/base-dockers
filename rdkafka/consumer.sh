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

echo "Test consumer $UPGRADING starting up"

echo "Test consumer listing topics from $TOPIC"
for i in $TOPIC; do
	echo "Test consumer topic $i"
done

DEBUG=""
#DEBUG="-X \"debug=broker,protocol,security\""

for t in $TOPIC; do 
	echo "Test consumer starting up for topic $t"
	rdkafka -C \
		-t $t \
		-p $PARTITION \
		-b $BROKER \
		-o $FROM $DEBUG \
		-X "group.id=$GROUP" \
		-X "sasl.mechanisms=$MECHANISM" \
		-X "security.protocol=$SECURITY_PROTOCOL" \
		-X "sasl.username=$SASL_USER" \
		-X "sasl.password=$SASL_PASS" \
		-X "socket.timeout.ms=30000" \
		-X "socket.keepalive.enable=true" \
		-X "log.connection.close=false" \
		&
done

touch /var/tmp/hold_open
while [ -e /var/tmp/hold_open ]; do 
	echo "Test consumer $UPGRADING running"
	sleep 30; 
done 

