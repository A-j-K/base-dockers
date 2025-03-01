FROM ubuntu:22.04 
MAINTAINER Andy Kirkham

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
	python-pip \
	cmake \
	autoconf \
	vim \
	file \
	wget

#COPY files/aws-cli-fed-requirements.txt /root/aws-cli-fed-requirements.txt

WORKDIR /tmp

# Install standard packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Install latest Golang version using PPA
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:longsleep/golang-backports \
	&&  DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y golang-go --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* 

# Install Terraform version 1.6.6 (last version before going none open source/commercial)
ENV TF_VERSION="1.6.6"

RUN	echo "export JAVA_HOME=\"/usr\"" >> /etc/bash.bashrc \
	&& echo "Loading Terraform ${TF_VERSION}" \
	&& curl -sSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip > terraform.zip \
	&& unzip terraform.zip \
	&& mv terraform /usr/local/bin/terraform \
	&& chmod 755 /usr/local/bin/terraform \
	&& rm -f terraform.zip 

# Install latest AWS CLI
RUN	mkdir -p /tmp/awscli-latest \
	&& cd /tmp/awscli-latest \
	&& curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
	&& unzip awscliv2.zip \
	&& ./aws/install \
	&& cd /root \
	&& rm -rf /tmp/awscli-latest

WORKDIR /root

