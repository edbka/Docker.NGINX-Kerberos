#!/bin/bash
set -e
username=$1
domain=$2
uppercasedomain=${domain^^}
password=$3
kvno=$4
localhost=$5

u="$(whoami)"
echo "Running version 1.01 as: $u"

usernameplusdomain="$username@$uppercasedomain"

echo "User name: $usernameplusdomain"

set -x

ktutil << EOF
addent -password -p $usernameplusdomain -k $kvno -e RC4-HMAC
$password
rkt /etc/nginx/$localhost.HTTP.keytab
rkt /etc/nginx/$localhost.hosts.keytab
wkt user.keytab
list
exit
EOF

kinit -kt user.keytab $usernameplusdomain -V
set +x
