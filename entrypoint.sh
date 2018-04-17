#!/bin/bash
./opt/install/configuredns.sh $domain $dc $dcip
./opt/install/configurekerberos.sh $domain $dc
./opt/install/configurenginx.sh $localhost $domain $remoteip $remoteport
./opt/install/setupkeytab.sh $username $domain $password $kvno $localhost

mv user.keytab /etc/nginx/user.keytab
chmod 740 /etc/nginx/user.keytab
chown root:nginx /etc/nginx/user.keytab
exec nginx -g "daemon off;"
#exec /bin/bash
