FROM alpine:3.2

# http://jumanjiman.github.io/
MAINTAINER Paul Morgan <jumanjiman@gmail.com>

# If you change this version, you need to change circle.yml
ENV VERSION=3.0.2-r10

# Install dependencies.
RUN apk upgrade --update --available && \
    apk add \
      "libssl1.0>=1.0.2e-r0" \
      "vsftpd>=${VERSION}" \
    && rm -f /var/cache/apk/*

EXPOSE 21/tcp
ENV LANG C

# Configure vsftpd.
COPY . /
RUN /usr/sbin/harden.sh

VOLUME ["/var/ftp/pub/uploads"]

CMD /start.sh
