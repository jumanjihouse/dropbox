# https://index.docker.io/_/fedora/
FROM fedora:latest

# http://jumanjiman.github.io/
MAINTAINER Paul Morgan <jumanjiman@gmail.com>

# Install dependencies.
RUN yum install -y vsftpd; yum clean all

# Create sandbox user for vsftpd to run unprivileged.
RUN useradd -s /sbin/nologin user

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
