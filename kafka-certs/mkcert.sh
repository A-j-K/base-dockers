#!/bin/bash

if [[ -z "${CA_PATH}" ]]; then
	CA_PATH=/var/certs
fi

if [[ -z "${CRT_FILE}" ]]; then
	CRT_FILE=ca-root-crt.pem
fi

if [[ -z "${KEY_FILE}" ]]; then
	KEY_FILE=ca-root-key.pem
fi

if [[ ! -e "${CA_PATH}/${KEY_FILE}" ]]; then
	echo "Not found ${CA_PATH}/${KEY_FILE}"
	exit 1
fi

if [[ ! -e "${CA_PATH}/${CRT_FILE}"  ]]; then
	echo "Not found ${CA_PATH}/${CRT_FILE}"
	exit 1
fi


if [[ -z "${OUTDIR}" ]]; then
	echo "No OUTDIR defined"
	exit 1
fi

if [[ -z "${STOREPASS}" ]]; then
	echo "No STOREPASS defined"
	exit 1
fi

if [[ -z "${C}" ]]; then
	echo "No SUBJECT/C defined"
	exit 1
fi

if [[ -z "${ST}" ]]; then
	echo "No SUBJECT/ST defined"
	exit 1
fi

if [[ -z "${L}" ]]; then
	echo "No SUBJECT/L defined"
	exit 1
fi

if [[ -z "${O}" ]]; then
	echo "No SUBJECT/O defined"
	exit 1
fi

if [[ -z "${OU}" ]]; then
	echo "No SUBJECT/OU defined"
	exit 1
fi

if [[ -z "${CN}" ]]; then
	echo "No SUBJECT/CN defined"
	exit 1
fi

if [[ -z "${emailAddress}" ]]; then
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
	-CA ${CA_PATH}/${CRT_FILE} \
	-CAkey ${CA_PATH}/${KEY_FILE} \
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
	-file ${CA_PATH}/${CRT_FILE}

echo "==> Creating JAVA broker certs store"
keytool \
	-noprompt \
	-trustcacerts \
	-keystore ${OUTDIR}/broker.jks \
	-alias CARoot \
	-import \
	-storepass "${STOREPASS}" \
	-file ${OUTDIR}/${CN}.crt


