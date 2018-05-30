# Kafka SSL Trust Stopre Generator

## Inputs

The Root CA certificates mounted thus:-
```
/etc/ca-root-key.pem
/etc/ca-root-crt.pem
```

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

