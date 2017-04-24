FROM ubuntu:16.04
MAINTAINER Andy Kirkham

# Command And Control node base definition

ENV TF_VERSION="0.9.3"
ENV PK_VERSION="1.0.0"
ENV DM_VERSION="0.10.0"

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common
RUN DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:ansible/ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update

ENV PKGS \
	ansible \
	git \
	curl \
	unzip \
	jq \
	awscli \
	openjdk-8-jdk \
	cmake \
	autoconf \
	apt-utils \
	vim \
	file

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends

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
RUN curl -sSL https://github.com/docker/machine/releases/download/v${DM_VERSION}/docker-machine-`uname -s`-`uname -m` >docker-machine \
	&& chmod +x docker-machine \
	&& mv docker-machine /usr/local/bin/docker-machine 
RUN curl -sSL http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz > apache-maven-3.3.9-bin.tar.gz \
	&& tar -zxf apache-maven-3.3.9-bin.tar.gz \
	&& rm -f apache-maven-3.3.9-bin.tar.gz \
	&& mv apache-maven-3.3.9 /usr/local \
	&& echo "export MVN_HOME=\"/usr/local/apache-maven-3.3.9\"" >> /etc/bash.bashrc \
	&& echo "export PATH=\"$PATH:/usr/local/apache-maven-3.3.9/bin\"" >> /etc/bash.bashrc
RUN curl -sSL http://www-eu.apache.org/dist//ant/binaries/apache-ant-1.10.1-bin.tar.gz > apache-ant-1.10.1-bin.tar.gz \
	&& tar -zxf apache-ant-1.10.1-bin.tar.gz \
	&& rm -f apache-ant-1.10.1-bin.tar.gz \
	&& mv apache-ant-1.10.1 /usr/local \
	&& echo "export ANT_HOME=\"/usr/local/apache-ant-1.10.1\"" >> /etc/bash.bashrc \
	&& echo "export PATH=\"$PATH:/usr/local/apache-ant-1.10.1/bin\"" >> /etc/bash.bashrc

RUN mkdir -p /workspace
WORKDIR /workspace

