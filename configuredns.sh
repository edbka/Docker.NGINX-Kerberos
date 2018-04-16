#!/bin/bash
domain=$1
uppercasedomain=${domain^^}
lowercasedomain=${domain,,}

dc=$2
dcip=$3


#echo "configuring resolv"
#echo "search " ${uppercasedomain} >> /etc/resolv.conf

#echo "Done resolv:"
cat /etc/resolv.conf

echo "configuring hosts"
echo ${dcip} ${dc}.${lowercasedomain} >> /etc/hosts
echo ${dcip} ${lowercasedomain} >> /etc/hosts

echo "Done hosts:"
cat /etc/hosts

