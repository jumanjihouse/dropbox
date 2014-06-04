#!/bin/bash

readonly logfile=/var/log/vsftpd.log

touch $logfile
chmod o+wx /var/ftp/pub/uploads
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
tail -f $logfile
