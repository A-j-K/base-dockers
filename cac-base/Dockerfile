FROM ubuntu:14.04
MAINTAINER Andy Kirkham

# Command And Control node base definition

ENV TF_VERSION="0.9.2"
ENV PK_VERSION="1.0.0"

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common
RUN DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:ansible/ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ansible git curl unzip jq awscli

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

RUN mkdir -p /workspace
WORKDIR /workspace

