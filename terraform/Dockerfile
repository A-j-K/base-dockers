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

ENV TF_VERSION="1.3.7"

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

WORKDIR /root

