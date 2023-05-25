# Simple Self-signed SSL Apache Server

Used for testing, when connecting your client will be given a self-signed cert.


## Build

Use the ````build.sh```` command to make a Docker image.

## Run

Use the ````run.sh```` command to run the image.

Note, listens on port 8000 for ordinary non-ssl http and 8443 for self-signed ssl, example

For ordinary http connection: ````curl "http://localhost:8000"````, this works

For SSL https connection ````curl "https://localhost:8443"````, this fails (self signed)

For SSL https connection ````curl -k "https://localhost:8443"````, this works (ignore self signed check)

To view the self-signed cert from this image:

    echo | openssl s_client -servername localhost -connect 127.0.0.1:8443 2>/dev/null | openssl x509 -text


To stop the container ````docker rm -f SELF````


