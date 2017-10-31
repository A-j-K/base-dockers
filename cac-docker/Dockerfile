FROM andykirkham/base-docker-cac-base
MAINTAINER Andy Kirkham

# Command And Control with Docker 

ENV DOCKER_VERSION="17.09.0-ce"

#RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

WORKDIR /tmp

# Install the Docker 
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz 
RUN groupadd docker
RUN tar --extract \
	--file docker-${DOCKER_VERSION}.tgz \
	--strip-components 1 \
	--directory /usr/local/bin/
RUN rm -f docker-${DOCKER_VERSION}.tgz

COPY docker-entrypoint.sh /usr/local/bin/

WORKDIR /workspace

EXPOSE 2375

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["bash"]

