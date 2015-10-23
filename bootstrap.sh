#!/bin/bash

if [ ! "`ls -A /data`" ]; then
    echo -n Creating SVN Server
    [ "$COMPATIBLE_VERSION" != "" ] && CREATE_OPTS="$CREATE_OPTS --compatible-version $COMPATIBLE_VERSION"
    echo " with options \"$CREATE_OPTS\""
    svnadmin create $CREATE_OPTS /data
    sed -E -i "s/(# )?anon-access.*/anon-access = $ANON_ACCESS/" "/data/conf/svnserve.conf"
    sed -E -i "s/(# )?auth-access.*/auth-access = $AUTH_ACCESS/" "/data/conf/svnserve.conf"
    sed -E -i "s/(# )?password-db.*/password-db = passwd/" "/data/conf/svnserve.conf"
    echo "$USERNAME = $PASSWORD" >> /data/conf/passwd
fi

echo Starting SVN Server

svnserve --foreground -d -r /data
