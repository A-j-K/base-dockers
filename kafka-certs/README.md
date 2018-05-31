# Kafka SSL Trust Stopre Generator

## Inputs

The Root CA certificates mounted thus:-
```
/var/certs/ca-root-key.pem
/var/certs/ca-root-crt.pem
```

We can override the Root CA certificate path and file names with Env vars (__optional__):
 * ``` $CA_PATH ``` Path for the Root CA certificate files, default: ```/var/certs```
 * ``` $KEY_FILE ``` CA root key file name, default: ```ca-root-key.pem```
 * ``` $CRT_FILE ``` CA root crt file name, default: ```ca-root-crt.pem```

The following Env Vars for __inputs__ are __required__

``` $CN ``` Common name

``` $C ```  Country code (example UK)

``` $ST ``` Region

``` $L ``` Location (example London)

``` $O ``` Organisation

``` $OU ``` Organisatiola Unit

``` $emailAddress ``` 

``` $STOREPASS ``` The JKS keystore password

__CN__ is the URL of your broker

## Outputs

The following Env Vars for __outputs__ are __required__

``` $OUTDIR ``` The directory to write certs (should be mounted into container writeable)

