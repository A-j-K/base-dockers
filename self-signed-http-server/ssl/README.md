# How this SSL Cert was made

In case I ever need to remember how I made the certs without asking Google/Stackoverflow:-

    openssl req -x509 -new -out mycert.crt -keyout mycert.key -days 36500 -newkey rsa:4096 -sha256 -nodes

    openssl req -x509 -new \
        -out mycert2.crt \
        -keyout mycert2.key \
        -days 36500 \
        -newkey rsa:2048 \
        -sha256 \
        -nodes \
        -subj "/CN=localhost" \
        -addext "subjectAltName=DNS:localhost"


