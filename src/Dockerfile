FROM alpine:3.2

# http://jumanjiman.github.io/
MAINTAINER Paul Morgan <jumanjiman@gmail.com>

# Install dependencies.
RUN apk upgrade --update --available && \
    apk add \
      vsftpd \
    && rm -f /var/cache/apk/*

EXPOSE 21/tcp
ENV LANG C

# Configure vsftpd.
COPY . /
RUN /usr/sbin/harden.sh

VOLUME ["/var/ftp/pub/uploads"]

CMD /start.sh
