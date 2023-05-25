# How this SSL Cert was made

In case I ever need to remember how I made the certs without asking Google/Stackoverflow:-

This was teh first way to create a cert:-

    openssl req -x509 -new -out mycert.crt -keyout mycert.key -days 36500 -newkey rsa:4096 -sha256 -nodes

This next way added the "addext" arg as GoLang programs check for this field:-

    openssl req -x509 -new \
        -out mycert2.crt \
        -keyout mycert2.key \
        -days 36500 \
        -newkey rsa:2048 \
        -sha256 \
        -nodes \
        -subj "/CN=localhost" \
        -addext "subjectAltName=DNS:localhost"


