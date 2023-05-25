# Simple Self-signed SSL Apache Server

Used for testing, when connecting your client will be given a self-signed cert.


## Build

Use the ````build.sh```` command to make a Docker image.

## Run

Use the ````run.sh```` command to run the image.

Note, listens on port 8000 for ordinary non-ssl http and 8443 for self-signed ssl, example

    ````curl "http://localhost:8000"```` for ordinary connection

    ````curl "https://localhost:8443"```` for SSL

To stop the container ````docker rm -f SELF````


