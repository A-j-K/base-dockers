FROM ubuntu:17.04
MAINTAINER Andy Kirkham

# Command And Control node base definition

ENV TF_VERSION="0.9.11"
ENV PK_VERSION="1.0.2"

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common
RUN DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:ansible/ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get update

ENV PKGS \
	ansible \
	git \
	subversion \
	curl \
	unzip \
	jq \
	awscli \
	openjdk-8-jdk \
	python-pip \
	cmake \
	autoconf \
	apt-utils \
	vim \
	file \
	gpg \
	qt4-default \
	libapr1-dev \
	libsvn-dev \
	libsvncpp-dev \
	libsvncpp3 libsvn1

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "export JAVA_HOME=\"/usr\"" >> /etc/bash.bashrc

WORKDIR /tmp
RUN curl -sSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip > terraform.zip \
	&& unzip terraform.zip \
	&& mv terraform /usr/local/bin/terraform \
	&& chmod 755 /usr/local/bin/terraform \
	&& rm -f terraform.zip
RUN curl -sSL https://releases.hashicorp.com/packer/${PK_VERSION}/packer_${PK_VERSION}_linux_amd64.zip > packer.zip \
	&& unzip packer.zip \
	&& mv packer /usr/local/bin/packer \
	&& chmod 755 /usr/local/bin/packer \
	&& rm -f packer.zip 
RUN curl -sSL http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz > apache-maven-3.3.9-bin.tar.gz \
	&& tar -zxf apache-maven-3.3.9-bin.tar.gz \
	&& rm -f apache-maven-3.3.9-bin.tar.gz \
	&& mv apache-maven-3.3.9 /usr/local \
	&& echo "export MVN_HOME=\"/usr/local/apache-maven-3.3.9\"" >> /etc/bash.bashrc 
RUN curl -sSL http://www-eu.apache.org/dist//ant/binaries/apache-ant-1.10.1-bin.tar.gz > apache-ant-1.10.1-bin.tar.gz \
	&& tar -zxf apache-ant-1.10.1-bin.tar.gz \
	&& rm -f apache-ant-1.10.1-bin.tar.gz \
	&& mv apache-ant-1.10.1 /usr/local \
	&& echo "export ANT_HOME=\"/usr/local/apache-ant-1.10.1\"" >> /etc/bash.bashrc 
RUN echo "export PATH=\"$PATH:/usr/local/apache-maven-3.3.9/bin:/usr/local/apache-ant-1.10.1/bin\"" >> /etc/bash.bashrc
RUN curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4_2.9-1_amd64.deb > libjansson4_2.9-1_amd64.deb \
        && dpkg -i libjansson4_2.9-1_amd64.deb \
        && rm -f libjansson4_2.9-1_amd64.deb
RUN curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson-dev_2.9-1_amd64.deb > libjansson-dev_2.9-1_amd64.deb \
        && dpkg -i libjansson-dev_2.9-1_amd64.deb \
        && rm -f libjansson-dev_2.9-1_amd64.deb
RUN curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4-dbgsym_2.9-1_amd64.ddeb > libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && dpkg -i libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && rm -f libjansson4-dbgsym_2.9-1_amd64.ddeb


RUN apt-get clean

RUN mkdir -p /workspace
WORKDIR /workspace

