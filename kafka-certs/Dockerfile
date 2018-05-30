FROM confluentinc/cp-kafka:4.1.1-2
ARG MAKE_USER
ARG USER_UID
ENV HISTFILE=
ENV HELM_VERSION="2.9.0"
ENV KUBECTL_VERSION="1.9.0"
ENV PKGS \
	ansible \
	vim \
	expect \
	curl \
	ssh \
	curl \
	openssl \
	libssl-dev \
	libffi-dev 
RUN 	groupadd -r $MAKE_USER \
	&& useradd \
		--uid $USER_UID \
		--home-dir /home/$MAKE_USER \
		-g $MAKE_USER \
		--shell /bin/bash \
		$MAKE_USER \
	&& mkdir -p /home/$MAKE_USER \
	&& chown -R $MAKE_USER:$MAKE_USER /home/$MAKE_USER \
	&& DEBIAN_FRONTEND=noninteractive apt update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential software-properties-common \
	&& DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y $PKGS --no-install-recommends \
	&& update-ca-certificates \
	&& curl -o kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
	&& chmod +x kubectl \
	&& mv kubectl /usr/local/bin/ \
	&& curl -o helm-v${HELM_VERSION}-linux-amd64.tar.gz https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
	&& tar -zxf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
	&& mv linux-amd64/helm /usr/local/bin/helm \
	&& rm -rf linux-amd64 \
	&& rm -f helm-v${HELM_VERSION}-linux-amd64.tar.gz \
	&& apt-get clean \
	&& rm -r /var/lib/apt/lists/* 
WORKDIR /home/$MAKE_USER
USER $MAKE_USER
CMD ["/bin/bash"]

