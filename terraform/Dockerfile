FROM ubuntu:20.04 
MAINTAINER Andy Kirkham

# Command And Control node base definition

# Command And Control node base definition

WORKDIR /tmp
ENV PKGS \
	ansible \
	git \
	ssh \
	subversion \
	curl \
	unzip \
	jq \
	openjdk-8-jdk \
	cmake \
	autoconf \
	apt-utils \
	vim \
	file \
	wget 

WORKDIR /tmp
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common apt-utils \
	&& DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:ansible/ansible \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* 

ENV TF_VERSION="0.13.6"
ENV PK_VERSION="1.5.2"

RUN	echo "Loading Terraform ${TF_VERSION}" \
	&& curl -sSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip > terraform.zip \
	&& unzip terraform.zip \
	&& mv terraform /usr/local/bin/terraform \
	&& chmod 755 /usr/local/bin/terraform \
	&& rm -f terraform.zip \
	&& echo "===> done." \
	&& apt-get clean \
	&& rm -r /var/lib/apt/lists/* \
	&& mkdir -p /workspace 

RUN	echo "==> Loading Packer ${PK_VERSION}" \
        && curl -sSL https://releases.hashicorp.com/packer/${PK_VERSION}/packer_${PK_VERSION}_linux_amd64.zip > packer.zip \
        && unzip packer.zip \
        && mv packer /usr/local/bin/packer \
        && chmod 755 /usr/local/bin/packer \
        && rm -f packer.zip \
        && echo "===> done." 

ARG UNAME=rundeck
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
RUN mkdir -p /root/rundeck && chown 1000:1000 /root/rundeck
WORKDIR /root/rundeck
USER $UNAME

