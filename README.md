## Overview

Docker-based ftp dropbox.

### User experience

The "ls" command is intentionally disabled and returns this error:

    ls: 550 Permission denied.

To upload a file successfully, please do the following:

    ftp> cd uploads
    ftp> put [filename]


### Admin

Start the container and put uploaded files into `/tmp`:

    docker pull jumanjiman/dropbox:latest
    docker run -d -p 21:21 -v /tmp:/var/ftp/pub/uploads --name dropbox jumanjiman/dropbox

Alternatively, create `/etc/systemd/system/dropbox.service` with:

    [Unit]
    Description=Dropbox
    After=docker.service
    Require=docker.service

    [Service]
    ExecStartPre=modprobe nf_conntrack_ftp
    ExecStartPre=modprobe nf_nat_ftp
    ExecStart=/bin/bash -c '/usr/bin/docker start dropbox || /usr/bin/docker run -d --name dropbox -v /tmp:/var/ftp/pub/uploads -p 21:21 jumanjiman/dropbox'
    ExecStop=/usr/bin/docker stop dropbox
    RestartSec=5s
    Restart=always

    [Install]
    WantedBy=multi-user.target

Then run:

    systemctl start dropbox.service
    systemctl enable dropbox.service


Test harness
------------

[![wercker status](https://app.wercker.com/status/5e3783b502f86813e39799ba012f69a6/s/master "wercker status")](https://app.wercker.com/project/bykey/5e3783b502f86813e39799ba012f69a6)

    jumanjiman/dropbox
      should use correct docker API version
      image should be available
      image properties
        should expose ftp port and only ftp port
        should have volume /var/ftp/pub/uploads

    users with interactive shells
      should only include "root"

    container
      should be available
      should accept anonymous login
      should deny directory listing
      should upload a file in binary mode
      upload should be readable by testuser
      should allow anonymous to mkdir

    contributor friction
      there should not be any

blah
