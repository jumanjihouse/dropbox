#!/bin/sh

readonly logfile=/var/log/vsftpd.log
tail -F $logfile &

touch $logfile
chmod o+wx /var/ftp/pub/uploads
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
