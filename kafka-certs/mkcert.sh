#!/bin/bash

if [[ ! -e /etc/ca-root-key.pem ]]; then
	echo "Not found /etc/ca-root-key.pem"
	exit 1
fi

if [[ ! -e /etc/ca-root-crt.pem ]]; then
	echo "Not found /etc/ca-root-crt.pem"
	exit 1
fi

if [[ -z $OUTDIR ]]; then
	echo "No OUTDIR defined"
	exit 1
fi

if [[ -z $STOREPASS ]]; then
	echo "No STOREPASS defined"
	exit 1
fi

if [[ -z $C ]]; then
	echo "No SUBJECT/C defined"
	exit 1
fi

if [[ -z $ST ]]; then
	echo "No SUBJECT/ST defined"
	exit 1
fi

if [[ -z $L ]]; then
	echo "No SUBJECT/L defined"
	exit 1
fi

if [[ -z $O ]]; then
	echo "No SUBJECT/O defined"
	exit 1
fi

if [[ -z $OU ]]; then
	echo "No SUBJECT/OU defined"
	exit 1
fi

if [[ -z $CN ]]; then
	echo "No SUBJECT/CN defined"
	exit 1
fi

if [[ -z $emailAddress ]]; then
	echo "No SUBJECT/emailAddress defined"
	exit 1
fi

SUBJECT="/C=${C}/ST=${ST}/L=${L}/O=${O}/OU=${OU}/CN=${CN}/emailAddress=${emailAddress}"

set -e 

echo "==> Generaing broker SSL private key"
openssl genrsa -out ${OUTDIR}/${CN}.key.pem 2048 

echo "==> Generating broker SSL CSR"
openssl req \
	-subj "${SUBJECT}" \
	-batch -new -key ${OUTDIR}/${CN}.key.pem -out ${OUTDIR}/${CN}.csr 

echo "==> Signing CSR with CA Root key"
openssl x509 -req \
	-in ${OUTDIR}/${CN}.csr \
	-CA /etc/ca-root-crt.pem \
	-CAkey /etc/ca-root-key.pem \
	-CAserial ${OUTDIR}/serial \
	-CAcreateserial \
	-set_serial 1 \
	-out ${OUTDIR}/${CN}.crt \
	-days 36500 \
	-sha256 

echo "==> Creating JAVA truststore"
keytool \
	-noprompt \
	-trustcacerts \
	-keystore ${OUTDIR}/truststore.jks \
	-alias CARoot \
	-import \
	-storepass "${STOREPASS}" \
	-file /etc/ca-root-crt.pem

echo "==> Creating JAVA broker certs store"
keytool \
	-noprompt \
	-trustcacerts \
	-keystore ${OUTDIR}/broker.jks \
	-alias CARoot \
	-import \
	-storepass "${STOREPASS}" \
	-file ${OUTDIR}/${CN}.crt


