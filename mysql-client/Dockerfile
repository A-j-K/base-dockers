FROM alpine:3.7
RUN apk update && apk add --no-cache mysql-client wget bash \
	&& rm -rf /var/lib/apt/lists/*
CMD ["/bin/bash"]
