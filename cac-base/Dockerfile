FROM andykirkham/ubuntu-image
MAINTAINER Andy Kirkham

# Command And Control node base definition

ENV TF_VERSION="0.10.7"
ENV PK_VERSION="1.1.1"
ENV MV_VERSION="3.5.2"
ENV ANT_VERSION="1.10.1"

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
RUN curl -sSL http://www-eu.apache.org/dist/maven/maven-3/${MV_VERSION}/binaries/apache-maven-${MV_VERSION}-bin.tar.gz > apache-maven-${MV_VERSION}-bin.tar.gz \
	&& tar -zxf apache-maven-${MV_VERSION}-bin.tar.gz \
	&& rm -f apache-maven-${MV_VERSION}-bin.tar.gz \
	&& mv apache-maven-${MV_VERSION} /usr/local \
	&& echo "export MVN_HOME=\"/usr/local/apache-maven-${MV_VERSION}\"" >> /etc/bash.bashrc 
RUN curl -sSL http://www-eu.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz > apache-ant-${ANT_VERSION}-bin.tar.gz \
	&& tar -zxf apache-ant-${ANT_VERSION}-bin.tar.gz \
	&& rm -f apache-ant-${ANT_VERSION}-bin.tar.gz \
	&& mv apache-ant-${ANT_VERSION} /usr/local \
	&& echo "export ANT_HOME=\"/usr/local/apache-ant-${ANT_VERSION}\"" >> /etc/bash.bashrc 
RUN echo "export PATH=\"$PATH:/usr/local/apache-maven-${MV_VERSION}/bin:/usr/local/apache-ant-${ANT_VERSION}/bin\"" >> /etc/bash.bashrc
RUN curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4_2.9-1_amd64.deb > libjansson4_2.9-1_amd64.deb \
        && dpkg -i libjansson4_2.9-1_amd64.deb \
        && rm -f libjansson4_2.9-1_amd64.deb
RUN curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson-dev_2.9-1_amd64.deb > libjansson-dev_2.9-1_amd64.deb \
        && dpkg -i libjansson-dev_2.9-1_amd64.deb \
        && rm -f libjansson-dev_2.9-1_amd64.deb
RUN curl -sSL https://launchpad.net/ubuntu/+archive/primary/+files/libjansson4-dbgsym_2.9-1_amd64.ddeb > libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && dpkg -i libjansson4-dbgsym_2.9-1_amd64.ddeb \
        && rm -f libjansson4-dbgsym_2.9-1_amd64.ddeb

# Because "apt-get install awscli" gives us a version that's too old.
RUN 	apt-get remove -y awscli 
RUN	curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
	&& unzip awscli-bundle.zip \
	&& ./awscli-bundle/install -i /usr/local/aws -b /usr/bin/aws \
	&& rm -rf awscli-bundle \
	&& rm -f awscli-bundle.zip

RUN wget -q --show-progress --https-only --timestamping \
	https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
	https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
RUN chmod +x cfssl_linux-amd64 cfssljson_linux-amd64
RUN mv cfssl_linux-amd64 /usr/local/bin/cfssl
RUN mv cfssljson_linux-amd64 /usr/local/bin/cfssljson

RUN curl -o kubectl https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/

RUN pip install eb

RUN apt-get clean

RUN mkdir -p /workspace
WORKDIR /workspace

