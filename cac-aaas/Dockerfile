#FROM ubuntu:18.04 
FROM python:3.7-stretch
MAINTAINER Andy Kirkham

WORKDIR /tmp
ENV PKGS \
	git \
	ssh \
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
	wget \
	qt4-default \
	libapr1-dev \
	libsvn-dev \
	libsvncpp-dev \
	libsvncpp3 \
	libsvn1 

COPY files/aws-cli-fed-requirements.txt /root/aws-cli-fed-requirements.txt

WORKDIR /tmp
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common apt-utils \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* 

ENV TF_VERSION="0.12.20"
ENV PK_VERSION="1.5.2"
ENV MV_VERSION="3.6.1"
ENV ANT_VERSION="1.10.7"
ENV HELM_VERSION="2.16.3"
ENV KUBECTL_VERSION="1.17.3"
ENV AWS_IAM_AUTHENTICATOR="1.14.6/2019-08-22"

RUN 	curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4_2.9-1_amd64.deb > libjansson4_2.9-1_amd64.deb \
        && DEBIAN_FRONTEND=noninteractive dpkg -i libjansson4_2.9-1_amd64.deb \
        && rm -f libjansson4_2.9-1_amd64.deb \
	&& curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson-dev_2.9-1_amd64.deb > libjansson-dev_2.9-1_amd64.deb \
        && DEBIAN_FRONTEND=noninteractive dpkg -i libjansson-dev_2.9-1_amd64.deb \
        && rm -f libjansson-dev_2.9-1_amd64.deb \
	&& curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4-dbgsym_2.9-1_amd64.ddeb > libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && DEBIAN_FRONTEND=noninteractive dpkg -i libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && rm -f libjansson4-dbgsym_2.9-1_amd64.ddeb \
	&& echo "export JAVA_HOME=\"/usr\"" >> /etc/bash.bashrc \
	&& echo "Loading Terraform ${TF_VERSION}" \
	&& curl -sSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip > terraform.zip \
	&& unzip terraform.zip \
	&& mv terraform /usr/local/bin/terraform \
	&& chmod 755 /usr/local/bin/terraform \
	&& rm -f terraform.zip \
	&& echo "==> Loading Packer ${PK_VERSION}" \
	&& curl -sSL https://releases.hashicorp.com/packer/${PK_VERSION}/packer_${PK_VERSION}_linux_amd64.zip > packer.zip \
	&& unzip packer.zip \
	&& mv packer /usr/local/bin/packer \
	&& chmod 755 /usr/local/bin/packer \
	&& rm -f packer.zip \
	&& echo "===> done." \
	&& echo "==> Loading Jansson 2.9.1" \
	&& curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4_2.9-1_amd64.deb > libjansson4_2.9-1_amd64.deb \
        && dpkg -i libjansson4_2.9-1_amd64.deb \
        && rm -f libjansson4_2.9-1_amd64.deb \
	&& echo "===> done." \
	&& curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson-dev_2.9-1_amd64.deb > libjansson-dev_2.9-1_amd64.deb \
        && dpkg -i libjansson-dev_2.9-1_amd64.deb \
        && rm -f libjansson-dev_2.9-1_amd64.deb \
	&& curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4-dbgsym_2.9-1_amd64.ddeb > libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && dpkg -i libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && rm -f libjansson4-dbgsym_2.9-1_amd64.ddeb \
	&& echo "===> done." \
# Because "apt-get install awscli" gives us a version that's too old.
	&& echo "==> Updating awscli" \
	&& apt-get remove -y awscli \
	&& curl -sSL "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
	&& unzip awscli-bundle.zip \
	&& ./awscli-bundle/install -i /usr/local/aws -b /usr/bin/aws \
	&& rm -rf awscli-bundle \
	&& rm -f awscli-bundle.zip \
	&& wget -q --https-only --timestamping \
		https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
		https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 \
	&& chmod +x cfssl_linux-amd64 cfssljson_linux-amd64 \
	&& mv cfssl_linux-amd64 /usr/local/bin/cfssl \
	&& mv cfssljson_linux-amd64 /usr/local/bin/cfssljson \
	&& echo "===> done." \
	&& echo "==> Loading kubectl ${KUBECTL_VERSION}" \
	&& curl -o kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
	&& chmod +x kubectl \
	&& mv kubectl /usr/local/bin/ \
	&& echo "===> done." \
	&& echo "==> Loading helm ${HELM_VERSION}" \
	&& curl -o helm-v${HELM_VERSION}-linux-amd64.tar.gz https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
	&& tar -zxf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
	&& mv linux-amd64/helm /usr/local/bin/helm \
	&& rm -rf linux-amd64 \
	&& rm -f helm-v${HELM_VERSION}-linux-amd64.tar.gz \
	&& echo "===> done." \
# Install eksctl
	&& echo "==> Installing eksctl" \
	&& curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
	&& mv /tmp/eksctl /usr/local/bin \
	&& chmod 755 /usr/local/bin/eksctl \
	&& echo "===> done." \
# Install aws-iam-authenticator
	&& echo "==> Installing aws-iam-authenticator" \
	&& curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/${AWS_IAM_AUTHENTICATOR}/bin/linux/amd64/aws-iam-authenticator \
	&& chmod +x ./aws-iam-authenticator \
	&& mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator \
	&& echo "===> done." \
	&& apt-get clean \
	&& rm -r /var/lib/apt/lists/* \
	&& mkdir -p /workspace

RUN pip install 'prompt-toolkit==1.0.15'
RUN pip install -r /root/aws-cli-fed-requirements.txt

WORKDIR /root

