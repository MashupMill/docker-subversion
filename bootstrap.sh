#!/bin/bash

if [ ! "`ls -A /data`" ]; then
    echo -n Creating SVN Server
    mkdir /data/repos
    htpasswd -b -c /data/.htpasswd $USERNAME $PASSWORD
    echo '[/]' >> /data/authz
    echo '* = rw' >> /data/authz
    [ "$COMPATIBLE_VERSION" != "" ] && CREATE_OPTS="$CREATE_OPTS --compatible-version $COMPATIBLE_VERSION"
    echo " with options \"$CREATE_OPTS\""
    svnadmin create $CREATE_OPTS /data/repos
    chown -R www-data:www-data /data/repos
fi

echo Starting SVN Server

#svnserve --foreground -d -r /data
/usr/sbin/apache2ctl -D FOREGROUND
