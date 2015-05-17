FROM alpine:latest

# http://jumanjiman.github.io/
MAINTAINER Paul Morgan <jumanjiman@gmail.com>

# Install dependencies.
RUN apk upgrade --update --available && \
    apk add \
      vsftpd \
    && rm -f /var/cache/apk/*

# Create sandbox user for vsftpd to run unprivileged.
# Remove accounts with interactive shells.
RUN adduser -D -s /sbin/nologin user && \
    deluser operator && \
    deluser postgres

EXPOSE 21/tcp
ENV LANG C

# Configure vsftpd.
ADD issue.net /etc/issue.net
ADD start.sh /start.sh

RUN mkdir -pm 0711 /var/empty/vsftpd
RUN mkdir -pm 2733 /var/ftp/pub/uploads
VOLUME ["/var/ftp/pub/uploads"]

ADD vsftpd.conf /etc/vsftpd/vsftpd.conf

CMD /start.sh
