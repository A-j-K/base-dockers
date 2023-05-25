FROM php:7.4-apache

WORKDIR /tmp
ENV PKGS \
	git \
	ssh \
	curl

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* 

COPY src/ /var/www/html/
COPY ssl/mycert.crt /etc/ssl/certs/mycert.crt
COPY ssl/mycert.key /etc/ssl/private/mycert.key
COPY ssl/mycert2.crt /etc/ssl/certs/mycert2.crt
COPY ssl/mycert2.key /etc/ssl/private/mycert2.key

RUN a2enmod ssl && a2enmod socache_shmcb
RUN sed -i '/SSLCertificateFile.*snakeoil\.pem/c\SSLCertificateFile \/etc\/ssl\/certs\/mycert2.crt' /etc/apache2/sites-available/default-ssl.conf
RUN sed -i '/SSLCertificateKeyFile.*snakeoil\.key/cSSLCertificateKeyFile /etc/ssl/private/mycert2.key\' /etc/apache2/sites-available/default-ssl.conf
RUN a2ensite default-ssl
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade -y



