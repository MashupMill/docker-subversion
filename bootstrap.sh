#!/bin/bash

if [ ! "`ls -A /data`" ]; then
    echo -n Creating SVN Server
    [ "$COMPATIBLE_VERSION" != "" ] && CREATE_OPTS="$CREATE_OPTS --compatible-version $COMPATIBLE_VERSION"
    echo " with options \"$CREATE_OPTS\""
    svnadmin create $CREATE_OPTS /data
    sed -E -i "s/(# )?anon-access.*/anon-access = $ANON_ACCESS/" "/data/conf/svnserve.conf"
    sed -E -i "s/(# )?auth-access.*/auth-access = $AUTH_ACCESS/" "/data/conf/svnserve.conf"
    sed -E -i "s/(# )?realm.*/realm = svnrealm/" "/data/conf/svnserve.conf"
    sed -E -i "s/(# )?use-sasl.*/use-sasl = true/" "/data/conf/svnserve.conf"
    sed -E -i "s/(# )?min-encryption.*/min-encryption = 128/" "/data/conf/svnserve.conf"
    sed -E -i "s/(# )?max-encryption.*/max-encryption = 256/" "/data/conf/svnserve.conf"

    echo "$PASSWORD" | saslpasswd2 -p -c -f /data/conf/sasldb -u svnrealm $USERNAME
    echo 'pwcheck_method: auxprop' >> /usr/lib/sasl2/svn.conf
    echo 'auxprop_plugin: sasldb' >> /usr/lib/sasl2/svn.conf
    echo 'sasldb_path: /data/conf/sasldb' >> /usr/lib/sasl2/svn.conf
    echo 'mech_list: DIGEST-MD5' >> /usr/lib/sasl2/svn.conf
fi

echo Starting SVN Server

svnserve --foreground -d -r /data
